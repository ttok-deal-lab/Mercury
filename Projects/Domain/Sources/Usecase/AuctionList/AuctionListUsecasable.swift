//
//  AuctionUsecasable.swift
//  Domain
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

import AppFoundation

public protocol AuctionSalesListUsecasable: Sendable {
  func fetchAuctionSales() async throws -> (auctionCount: Int?, items: [AuctionSalesItem])
  func fetchNextAuctionSales() async throws -> [AuctionSalesItem]
}
