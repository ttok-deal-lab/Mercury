//
//  InterestRepository.swift
//  Infrastructure
//
//  Created by 최수훈 on 1/12/26.
//
import Foundation

import AppFoundation
import Domain

public final class AuctionInterestRepository: AuctionInterestRepositoriable {
  
  public init() { }
  
  public func isAuctionUserInterested(auctionID: Int) async throws -> Bool {
    
  }
  
  public func addUserInterestAuction(auctionID: Int) async throws {
    
  }
  
  public func removeUserInterestAuction(userID: String, auctionID: Int) async throws {
    try await AuctionInterestAPI
      .removeUserInterestAuction(userID: userID, auctionID: auctionID)
      .request()
  }
  
  public func fetchUserInterestAuctions(userID: String) async throws -> InterestSales {
    let interestSalesDTO = try await AuctionInterestAPI
      .fetchUserInterestAuctions(userID: userID)
      .request([InterestItemDTO].self)
    
    let interestItemList = interestSalesDTO.map { $0.toEntity() }
  }
  
  
}
