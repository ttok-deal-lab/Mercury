//
//  AuctionDetailRepositorable.swift
//  Domain
//
//  Created by 송하민 on 11/1/25.
//

import Foundation

public protocol AuctionDetailRepositorable: Sendable {
  func auctionDetail(auctionID: Int) async throws -> AuctionDetail
  func auctionDetails(auctionIDs: [Int], size: Int) async throws -> [AuctionDetail]
}
