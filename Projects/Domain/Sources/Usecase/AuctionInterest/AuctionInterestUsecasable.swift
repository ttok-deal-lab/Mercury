//
//  AuctionInterestUsecasable.swift
//  Domain
//
//  Created by 송하민 on 1/3/26.
//

import Foundation

public protocol AuctionInterestUsecasable: Sendable {
  func isAuctionUserInterested(auctionID: Int) async throws -> Bool
  func addUserInterest(auctionID: Int) async throws
  func removeUserInterest(auctionID: Int) async throws
  func fetchAuctionInterest() async throws
}
