//
//  SearchModelData.swift
//  Search
//
//  Created by 송하민 on 12/28/25.
//

import SwiftUI
import Combine

import Domain
import Router
import UIComponent

@Observable
final class SearchModelData {
  enum LocalStorageKey: String {
    case latestSearchText /// 변경하지 말 것. 하위호환 불가하게 됨
  }
  
  var latestSearchTexts: [String] = []
  var auctionSalesItems: [AuctionSalesItem] = []
  private(set) var auctionSearchFilter: AuctionSearchFilter?
  var currentAuctionFilter = CurrentAuctionFilter()
  
  var isLoading: Bool = false
  var isLoadingForPaging: Bool = false
  var error: Error?

  var filteredItemCount: Int = .zero
  
  // MARK: - Private Property
  
  private let auctionListUsecase: AuctionSalesListUsecase
  private let auctionSearchFilterUsecase: AuctionSearchFilterUsecasable
  private let localStorageUsecase: LocalStorageUsecase
  
  // MARK: - Initialize
  
  init(
    auctionSalesListUsecase: AuctionSalesListUsecase,
    auctionSearchFilterUsecase: AuctionSearchFilterUsecasable,
    localStorageUsecase: LocalStorageUsecase
  ) {
    self.auctionListUsecase = auctionSalesListUsecase
    self.auctionSearchFilterUsecase = auctionSearchFilterUsecase
    self.localStorageUsecase = localStorageUsecase
    
    fetchLatestSearchTexts()
    Task {
      do {
        try await fetchSearchFilters()
      } catch {
        self.error = error
      }
    }
  }
  
  // MARK: - Private Methods
  
  private func updateLatestSearchList(_ list: [String]) async {
    self.latestSearchTexts = list
  }
  
  private func fetchLatestSearchTexts() {
    Task {
      let list = await localStorageUsecase.getModel(
        forKey: LocalStorageKey.latestSearchText.rawValue,
        as: [String].self
      ) ?? []
      
      await updateLatestSearchList(list)
    }
  }
  
  private func saveLatestSearchText(searchedText: String?) {
    guard let searchedText, !searchedText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
    
    Task {
      var currentList = await localStorageUsecase.getModel(
        forKey: LocalStorageKey.latestSearchText.rawValue,
        as: [String].self
      ) ?? []
      currentList.removeAll { $0 == searchedText }
      currentList.insert(searchedText, at: 0)
      if currentList.count > 10 {
        currentList = Array(currentList.prefix(10))
      }
      await localStorageUsecase.setModel(
        currentList,
        forKey: LocalStorageKey.latestSearchText.rawValue
      )
      await updateLatestSearchList(currentList)
    }
  }
  
  // MARK: - Internal Methods
  
  func removeLatestSearchText(text: String) {
    Task {
      var currentList = await localStorageUsecase.getModel(
        forKey: LocalStorageKey.latestSearchText.rawValue,
        as: [String].self
      ) ?? []
      currentList.removeAll { $0 == text }
      await localStorageUsecase.setModel(
        currentList,
        forKey: LocalStorageKey.latestSearchText.rawValue
      )
      await updateLatestSearchList(currentList)
    }
  }
  
  func removeAllLatestSearchText() {
    Task {
      let emptyList: [String] = []
      await localStorageUsecase.setModel(
        emptyList,
        forKey: LocalStorageKey.latestSearchText.rawValue
      )
      await updateLatestSearchList(emptyList)
    }
  }
  
  func typing() {
    self.currentAuctionFilter.clear()
    self.auctionSalesItems.removeAll()
  }
  
  func search(with text: String?) {
    self.currentAuctionFilter.keyword = text
    self.saveLatestSearchText(searchedText: text)
    Task {
      await self.loadAuctionSalesList()
    }
  }
  
  func loadAuctionSalesList() async {
    self.isLoading = true
    defer {
      self.isLoading = false
    }
    
    do {
      let auctionSales = try await auctionListUsecase.fetchAuctionSales(filter: self.currentAuctionFilter)
      if let auctionCount = auctionSales.auctionCount {
        self.filteredItemCount = auctionCount
      }
      self.auctionSalesItems = auctionSales.items
      
    } catch let error {
      self.error = error
    }
  }
  
  func loadMoreAuctionSales() async {
    withAnimation {
      self.isLoadingForPaging = true
    }
    defer {
      withAnimation {
        self.isLoadingForPaging = false
      }
    }
    let currentAuctionSalesItems = self.auctionSalesItems
    do {
      let auctionSalesItems = try await auctionListUsecase.fetchNextAuctionSales(filter: self.currentAuctionFilter)
      self.auctionSalesItems = currentAuctionSalesItems + auctionSalesItems
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
}

// 필터
extension SearchModelData {
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
