//
//  RecentSalesModelData.swift
//  MyPage
//
//  Created by 최수훈 on 12/26/25.
//

import SwiftUI
import Combine

import AppFoundation
import Domain

@Observable
final class RecentSalesModelData {
  // MARK: - internal property
  var recentViewList: [RecentSalesItem] = []
  var isLoading: Bool = false
  var error: Error?
  // MARK: - private property
  private let recentViewListUsecase: RecentSalesUsecasable
  private let auctionInterestUsecase: AuctionInterestUsecasable
  // MARK: - life cycle
  
  init(recentViewListUsecase: RecentSalesUsecasable,
       auctionInterestUsecase: AuctionInterestUsecasable
  ) {
    self.recentViewListUsecase = recentViewListUsecase
    self.auctionInterestUsecase = auctionInterestUsecase
  }
  
  func loadRecentViewList() async throws {
    self.isLoading = true
    defer {
      self.isLoading = false
    }
    do {
      
      let recentList = try await recentViewListUsecase.fetchRecentViewList()
      let updatedInterestList = try await self.loadInterestAuctionList(list: recentList)
      
      self.recentViewList = updatedInterestList
    } catch let error {
      self.error = error
    }
  }
  
  @MainActor
  // 관심매물 추가
  func tapOnZzim(auctionID: Int) async throws {
    guard let index = self.recentViewList.firstIndex(where: { $0.id == auctionID }) else { return }

    var targetItem = self.recentViewList[index]
    let isCurrentlyZzim = targetItem.isZzim
    if !isCurrentlyZzim {
      try await auctionInterestUsecase
        .addInterest(auctionID: auctionID)
    } else {
      try await auctionInterestUsecase
        .removeInterest(auctionID: auctionID)
    }
    targetItem.zzimCount += isCurrentlyZzim ? -1 : 1
    targetItem.isZzim.toggle()
    self.recentViewList[index] = targetItem
    NotificationCenter.default.post(
      name: .auctionZzimDidChange,
      object: nil,
      userInfo: [
        "auctionID": targetItem.id,
        "isZzimed": targetItem.isZzim,
        "zzimCount": targetItem.zzimCount
      ]
    )
  }
  
  func isAuctionUserInterested(auctionID: Int) async throws -> Bool {
    let isZzim = try await auctionInterestUsecase.isAuctionInterested(auctionID: auctionID)
    return isZzim
  }

  func refreshInterestStatus() async {
    guard !recentViewList.isEmpty else { return }
    do {
      let updatedList = try await loadInterestAuctionList(list: recentViewList)
      self.recentViewList = updatedList
    } catch {
      self.error = error
    }
  }

  func syncZzimState(auctionID: Int, isZzimed: Bool, zzimCount: Int) {
    guard let index = self.recentViewList.firstIndex(where: { $0.id == auctionID }) else { return }

    var targetItem = self.recentViewList[index]
    targetItem.isZzim = isZzimed
    targetItem.zzimCount = zzimCount
    self.recentViewList[index] = targetItem
  }
  
  // 관심매물 여부 리스트 검사 (메모리 isZzim 우선, 신규 ID만 서버 조회)
  private func loadInterestAuctionList(list: [RecentSalesItem]) async throws -> [RecentSalesItem]{
    guard !list.isEmpty else { return [] }
    var itemList = list
    let previousZzimMap = Dictionary(uniqueKeysWithValues: self.recentViewList.map { ($0.id, $0.isZzim) })

    for i in itemList.indices {
      if let prevZzim = previousZzimMap[itemList[i].id] {
        itemList[i].isZzim = prevZzim
      }
    }

    let newIDs = itemList.filter { previousZzimMap[$0.id] == nil }.map { $0.id }
    guard !newIDs.isEmpty else { return itemList }

    let interestWhetherList = try await auctionInterestUsecase.loadInterestList(ids: newIDs)
    for inter in interestWhetherList {
      guard let index = itemList.firstIndex(where: { $0.id == inter.id }) else { continue }
      itemList[index].isZzim = inter.favorite
    }
    return itemList
  }
  
}
