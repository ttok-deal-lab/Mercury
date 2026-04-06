//
//  RecentSalesModelData.swift
//  MyPage
//
//  Created by 최수훈 on 12/26/25.
//

import SwiftUI
import Combine

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
  
  // 관심매물 추가
  func tapOnZzim(auctionID: Int) async throws {
    guard let index = self.recentViewList.firstIndex(where: { $0.id == auctionID }) else { return }
    
    var targetItem = self.recentViewList[index]
    let isNowZzim = try await isAuctionUserInterested(auctionID: auctionID)
    if !isNowZzim {
      try await auctionInterestUsecase
        .addUserInterestAuction(auctionID: auctionID)
    } else {
      try await auctionInterestUsecase
        .removeUserInterestAuction(auctionID: auctionID)
    }
    targetItem.zzimCount += isNowZzim ? -1 : 1
    targetItem.isZzim.toggle()
    self.recentViewList[index] = targetItem
  }
  
  func isAuctionUserInterested(auctionID: Int) async throws -> Bool {
    let isZzim = try await auctionInterestUsecase.isAuctionUserInterested(auctionID: auctionID)
    return isZzim
  }
  
  // 관심매물 여부 리스트 검사
  private func loadInterestAuctionList(list: [RecentSalesItem]) async throws -> [RecentSalesItem]{
    var itemList = list
    let ids = itemList.map { $0.id }
    let interestWhetherList = try await auctionInterestUsecase.loadInterestAuctionList(ids: ids)
    
    for inter in interestWhetherList {
      guard let index = itemList.firstIndex(where: { $0.id == inter.id }) else { return itemList }
      
      var targetItem = itemList[index]
      targetItem.isZzim = inter.favorite
      itemList[index] = targetItem
    }
    return itemList
  }
  
}
