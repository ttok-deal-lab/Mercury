//
//  AuctinoInterestRepositoriable.swift
//  Domain
//
//  Created by 최수훈 on 1/20/26.
//

public protocol AuctionInterestRepositoriable: Sendable {
  func isAuctionUserInterested(auctionID: Int) async throws -> Bool
  func addUserInterestAuction(auctionID: Int) async throws
  func removeUserInterestAuction(userID: String, auctionID: Int) async throws
  func fetchUserInterestAuctions() async throws -> InterestSales
}
