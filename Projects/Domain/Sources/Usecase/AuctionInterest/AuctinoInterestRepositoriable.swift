//
//  AuctinoInterestRepositoriable.swift
//  Domain
//
//  Created by 최수훈 on 1/20/26.
//

public protocol AuctionInterestRepositoriable {
  func isAuctionInterested(auctionID: Int) async throws -> Bool
  func addInterest(auctionID: Int) async throws
  func removeInterest(auctionID: Int) async throws
  func fetchInterest(type: String?, cursor: String?) async throws -> InterestSales
  func fetchInterestList(ids: [Int]) async throws -> [InterestWhether]
}
