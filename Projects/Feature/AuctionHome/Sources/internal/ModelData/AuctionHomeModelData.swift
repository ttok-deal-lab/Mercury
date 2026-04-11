//
//  AuctionHomeModelData.swift
//  Auction
//
//  Created by 송하민 on 5/4/25.
//

import Foundation
import SwiftUI
import SwiftData

import AppFoundation
import Domain
import UIComponent

@Observable
final class AuctionHomeModelData {
  // MARK: - Internal Properties
  
  var auctionSalesItems: [AuctionSalesItem] = []
  private(set) var auctionSearchFilter: AuctionSearchFilter?
  
  var currentAuctionFilter = CurrentAuctionFilter()
  
  var isLoading: Bool = false
  var isLoadingForPaging: Bool = false
  var filteredItemCount: Int = .zero
  var error: Error?
  
  // MARK: - Private Properties
  
  private let localStorageUsecase: LocalStorageUsecasable
  private let auctionListUsecase: AuctionSalesListUsecasable
  private let auctionSearchFilterUsecase: AuctionSearchFilterUsecasable
  private let auctionInterestUsecase: AuctionInterestUsecasable
  
  // MARK: - Initialize
  
  init(
    localStorageUsecase: LocalStorageUsecasable,
    auctionListUsecase: AuctionSalesListUsecasable,
    auctionSearchFilterUsecase: AuctionSearchFilterUsecasable,
    auctionInterestUsecase: AuctionInterestUsecasable
  ) {
    self.localStorageUsecase = localStorageUsecase
    self.auctionListUsecase = auctionListUsecase
    self.auctionSearchFilterUsecase = auctionSearchFilterUsecase
    self.auctionInterestUsecase = auctionInterestUsecase
    
    Task {
      do {
        try await fetchSearchFilters()
      } catch {
        self.error = error
      }
    }
  }
  
  // MARK: - Private Methods
  
  // MARK: - Internal Methods
  
  // 경매물건 불러오기
  func loadAuctionSalesList(withFilter: Bool = true) async {
    self.isLoading = true
    defer {
      self.isLoading = false
    }
    
    do {
      let auctionSales = try await auctionListUsecase.fetchAuctionSales(
        filter: withFilter ? self.currentAuctionFilter : nil
      )
      if let auctionCount = auctionSales.auctionCount {
        self.filteredItemCount = auctionCount
      }
      let updatedInterestList = try await self.loadInterestAuctionList(list: auctionSales.items)
      
      self.auctionSalesItems = updatedInterestList
    } catch let error {
      self.error = error
    }
  }
  
  // 경매물건 추가로 불러오기
  func loadMoreAuctionSales() async {
    self.isLoadingForPaging = true
    defer {
      self.isLoadingForPaging = false
    }
    let currentAuctionSalesItems = self.auctionSalesItems
    do {
      let auctionSalesItems = try await auctionListUsecase.fetchNextAuctionSales(filter: self.currentAuctionFilter)
      let updatedInterestList = try await self.loadInterestAuctionList(list: auctionSalesItems)
      
      self.auctionSalesItems = currentAuctionSalesItems + updatedInterestList
    } catch {
      self.error = error
    }
  }
  
  // 필터 가져오기
  func fetchSearchFilters() async throws {
    let filters = try await auctionSearchFilterUsecase.fetchAuctionSearchFilters()
    self.auctionSearchFilter = filters
    
    if let defaultSort = filters.searchOptions.first {
      self.currentAuctionFilter.sort = defaultSort
    }
    if let defaultRegion = filters.regions.first {
      self.currentAuctionFilter.region = defaultRegion
    }
  }
  
  // 최근본 매물 저장
  func saveRecentSales(id: Int) async {
    var recentSales: [RecentSalesInfo] = await localStorageUsecase.getModel(
      forKey: LocalStorageKey.recentViwedSales.rawValue,
      as: [RecentSalesInfo].self
    ) ?? []
    let date = Date.now
    
    let newItem = RecentSalesInfo(id: id, date: date)
    
    if let index = recentSales.firstIndex(of: newItem) {
      recentSales.remove(at: index)
    }
    recentSales.insert(newItem, at: 0)
    
    if recentSales.count > 50 { // 정책 정하기 전 임시 갯수 제한
      recentSales.removeLast()
    }
    await localStorageUsecase.setModel(recentSales, forKey: LocalStorageKey.recentViwedSales.rawValue)
  }
  
  
  
  @MainActor
  // 관심매물 추가
  func tapOnZzim(auctionID: Int) async throws {
    guard let index = self.auctionSalesItems.firstIndex(where: { $0.id == auctionID }) else { return }
    
    var targetItem = self.auctionSalesItems[index]
    let isNowZzim = try await isAuctionUserInterested(auctionID: auctionID)
    if !isNowZzim {
      try await auctionInterestUsecase
        .addInterest(auctionID: auctionID)
    } else {
      try await auctionInterestUsecase
        .removeInterest(auctionID: auctionID)
    }
    targetItem.zzimCount += isNowZzim ? -1 : 1
    targetItem.isZzim.toggle()
    self.auctionSalesItems[index] = targetItem
    NotificationCenter.default.post(
      name: .auctionZzimDidChange,
      object: nil,
      userInfo: [
        AuctionZzimChangeUserInfoKey.auctionID: auctionID,
        AuctionZzimChangeUserInfoKey.isZzimed: targetItem.isZzim,
        AuctionZzimChangeUserInfoKey.zzimCount: targetItem.zzimCount
      ]
    )
  }
  
  func refreshInterestStatus() async {
    guard !auctionSalesItems.isEmpty else { return }
    do {
      let updatedList = try await loadInterestAuctionList(list: auctionSalesItems)
      self.auctionSalesItems = updatedList
    } catch {
      self.error = error
    }
  }

  
  func isAuctionUserInterested(auctionID: Int) async throws -> Bool {
    let isZzim = try await auctionInterestUsecase.isAuctionInterested(auctionID: auctionID)
    return isZzim
  }
  
  // 관심매물 여부 리스트 검사
  private func loadInterestAuctionList(list: [AuctionSalesItem]) async throws -> [AuctionSalesItem]{
    guard !list.isEmpty else { return [] }
    var itemList = list
    let ids = itemList.map { $0.id }
    let interestWhetherList = try await auctionInterestUsecase.loadInterestList(ids: ids)
    
    for inter in interestWhetherList {
      guard let index = itemList.firstIndex(where: { $0.id == inter.id }) else { return itemList }
      
      var targetItem = itemList[index]
      targetItem.isZzim = inter.favorite
      itemList[index] = targetItem
    }
    return itemList
  }
  
  func syncZzimState(auctionID: Int, isZzimed: Bool, zzimCount: Int) {
    guard let index = self.auctionSalesItems.firstIndex(where: { $0.id == auctionID }) else { return }
    
    var targetItem = self.auctionSalesItems[index]
    targetItem.isZzim = isZzimed
    targetItem.zzimCount = zzimCount
    self.auctionSalesItems[index] = targetItem
  }
  
}

private enum AuctionZzimChangeUserInfoKey {
  static let auctionID = "auctionID"
  static let isZzimed = "isZzimed"
  static let zzimCount = "zzimCount"
}

// 필터처리
extension AuctionHomeModelData {
  func isFilterActive(_ type: AuctionFilterType) -> Bool {
    switch type {
    case .certified:
      return currentAuctionFilter.isCertified
    case .buildingUsage:
      return !(currentAuctionFilter.buildingTypeCodes?.isEmpty ?? true)
    case .auctionStatus:
      return !(currentAuctionFilter.auctionFailCodes?.isEmpty ?? true)
    case .price:
      return currentAuctionFilter.minimumPrice != nil || currentAuctionFilter.maximumPrice != nil
    case .bidWon:
      return currentAuctionFilter.isBidWon
    }
  }
  
  func displayTitle(for type: AuctionFilterType) -> String {
    switch type {
    case .buildingUsage:
      let selectedCodes = currentAuctionFilter.buildingTypeCodes ?? []
      if selectedCodes.isEmpty { return type.defaultTitle }
      
      let allOptions = auctionSearchFilter?.buildingTypes ?? []
      let selectedNames = allOptions
        .filter { selectedCodes.contains($0.code) }
        .map { $0.displayName }
      
      if let firstName = selectedNames.first {
        return selectedNames.count > 1
        ? L10n.auctionFilterMultiSelect(firstName, selectedNames.count - 1)
        : firstName
      }
      return type.defaultTitle
      
    case .auctionStatus:
      let selectedCodes = currentAuctionFilter.auctionFailCodes ?? []
      if selectedCodes.isEmpty { return type.defaultTitle }
      
      let allOptions = auctionSearchFilter?.auctionFailOptions ?? []
      let selectedNames = allOptions
        .filter { selectedCodes.contains($0.code) }
        .map { $0.displayName }
      
      if let firstName = selectedNames.first {
        return selectedNames.count > 1
        ? L10n.auctionFilterMultiSelect(firstName, selectedNames.count - 1)
        : firstName
      }
      return type.defaultTitle
      
    case .price:
      return makePriceString() ?? type.defaultTitle
      
    default:
      return type.defaultTitle
    }
  }
  
  private func makePriceString() -> String? {
    let min = currentAuctionFilter.minimumPrice
    let max = currentAuctionFilter.maximumPrice
    
    if let min, min > 0, let max, max > 0 {
      return "\(min.toKoreanFullWon) 이상 \(max.toKoreanFullWon) 이하"
    } else if let min, min > 0 {
      return "\(min.toKoreanFullWon) 이상"
    } else if let max, max > 0 {
      return "\(max.toKoreanFullWon) 이하"
    }
    return nil
  }
}
