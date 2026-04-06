//
//  AuctionInterestUsecasable.swift
//  Domain
//
//  Created by 송하민 on 1/3/26.
//

import Foundation

public protocol AuctionInterestUsecasable: Sendable {
  func isAuctionInterested(auctionID: Int) async throws -> Bool
  func addInterest(auctionID: Int) async throws
  func removeInterest(auctionID: Int) async throws
  func loadInterest() async throws -> [InterestItem]
  func loadNextInterest() async throws -> [InterestItem]
  func loadInterestList(ids: [Int]) async throws -> [InterestWhether]
}
