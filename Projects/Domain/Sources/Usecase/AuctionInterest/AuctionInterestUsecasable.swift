//
//  AuctionInterestUsecasable.swift
//  Domain
//
//  Created by 송하민 on 1/3/26.
//

import Foundation

public protocol AuctionInterestUsecasable: Sendable {
  func isAuctionUserInterested(auctionID: Int) async throws -> Bool
  func addUserInterestAuction(auctionID: Int) async throws
  func removeUserInterestAuction(auctionID: Int) async throws
  func loadUserInterestAuctions() async throws -> [InterestItem]
  func loadNextInterestAuctions() async throws -> [InterestItem]
  func loadInterestAuctionList(ids: [Int]) async throws -> [InterestWhether]
}
