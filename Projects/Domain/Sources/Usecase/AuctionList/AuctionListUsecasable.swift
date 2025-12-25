//
//  AuctionUsecasable.swift
//  Domain
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

import AppFoundation

public protocol AuctionSalesListUsecasable: Sendable {
  func fetchAuctionSales(filter: CurrentAuctionFilter?) async throws -> (auctionCount: Int?, items: [AuctionSalesItem])
  func fetchNextAuctionSales(filter: CurrentAuctionFilter?) async throws -> [AuctionSalesItem]
}
