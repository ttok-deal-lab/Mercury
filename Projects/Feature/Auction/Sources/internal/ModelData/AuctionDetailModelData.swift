//
//  AuctionDetailModelData.swift
//  Auction
//
//  Created by 송하민 on 11/1/25.
//

import Foundation
import SwiftUI
import Combine

import AppFoundation
import Domain

@Observable
@MainActor
public final class AuctionDetailModelData {
  
  // MARK: - internal properties
  
  var error: MercuryError?
  var auctionDetailItem: AuctionDetail?
  
  // MARK: - private properties
  
  private let auctionDetailUsecase: AuctionDetailUsecase
  private let auctionID: Int
  
  // MARK: - life cycle
  
  public init(auctionDetailUsecase: AuctionDetailUsecase, auctionID: Int) {
    self.auctionDetailUsecase = auctionDetailUsecase
    self.auctionID = auctionID
    Task { [weak self] in
      do {
        let item = try await self?.fetchAuctionDetailItem()
        self?.auctionDetailItem = item
      } catch let error as MercuryError {
        self?.error = error
      }
    }
  }
  
  // MARK: - private methods
  
  private func fetchAuctionDetailItem() async throws -> AuctionDetail {
    return try await self.auctionDetailUsecase.fetchAuctionDetail(auctionID: self.auctionID)
  }
  
}
