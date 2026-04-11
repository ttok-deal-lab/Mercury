//
//  ReportModelData.swift
//  Report
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import AppFoundation
import Domain

@Observable
final class AuctionInterestModelData {
  // MARK: - internal property
  var interestList: [InterestItem] = []
  var isLoading = false
  var isLoadingForPaging: Bool = false
  // MARK: - private property
  private let interestUsecase: AuctionInterestUsecasable
  
  var error: Error?
  
  // MARK: - life cycle
  init(interestUsecase: AuctionInterestUsecasable) {
    self.interestUsecase = interestUsecase
  }
  
  func loadUserInterestAuctions() async {
    self.isLoading = true
    defer {
      self.isLoading = false
    }
    do {
      await self.interestUsecase.resetPagination()
      let interestList = try await self.interestUsecase.loadInterest()
      self.interestList = interestList
    } catch let error {
      self.error = error
    }
  }
  
  func loadMoreInterestSales() async {
    guard !isLoadingForPaging else { return }
    self.isLoadingForPaging = true
    defer {
      self.isLoadingForPaging = false
    }
    
    do {
      let interestItems = try await interestUsecase.loadNextInterest()
      let existingIDs = Set(interestList.map(\.id))
      let newItems = interestItems.filter { !existingIDs.contains($0.id) }
      self.interestList += newItems
    } catch {
      self.error = error
    }
  }
  
  @MainActor
  func removeAndDeleteInterest(item: InterestItem) async {
    do {
      try await self.interestUsecase.removeInterest(auctionID: item.id)
      self.interestList.removeAll { $0.id == item.id }
      NotificationCenter.default.post(
        name: .auctionZzimDidChange,
        object: nil,
        userInfo: [
          "auctionID": item.id,
          "isZzimed": false,
          "zzimCount": max(0, item.zzimCount - 1)
        ]
      )
    } catch {
      self.error = error
    }
  }
}


