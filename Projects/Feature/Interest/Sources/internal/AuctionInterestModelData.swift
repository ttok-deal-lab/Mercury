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
      let interestList = try await self.interestUsecase.loadUserInterestAuctions()
      self.interestList = interestList
    } catch let error {
      self.error = error
    }
  }
  
  func loadMoreInterestSales() async {
    self.isLoadingForPaging = true
    defer {
      self.isLoadingForPaging = false
    }
    
    let currentInterestSalesItem = self.interestList
    
    do {
      let interestItems = try await interestUsecase.loadNextInterestAuctions()
      self.interestList = currentInterestSalesItem + interestItems
    } catch {
      self.error = error
    }
  }
  
  func removeUserInterestAuction(auctionID: Int) async throws {
    try await self.interestUsecase.removeUserInterestAuction(auctionID: auctionID)
  }
}


