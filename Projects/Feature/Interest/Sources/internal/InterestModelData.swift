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
final class InterestModelData {
  // MARK: - internal property
  var interestList: [InterestItem] = []
  var isLoading = false
  var isLoadingForPaging: Bool = false
  // MARK: - private property
  private let interestUsecase: AuctionInterestUsecasable
  
  // MARK: - life cycle
  init(interestUsecase: AuctionInterestUsecasable) {
    self.interestUsecase = interestUsecase
  }
  
  func removeUserInterestAuction(auctionID: Int) async throws {
    try await self.interestUsecase.removeUserInterestAuction(auctionID: auctionID)
  }
}


