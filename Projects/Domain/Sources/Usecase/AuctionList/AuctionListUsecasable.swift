//
//  AuctionUsecasable.swift
//  Domain
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

import AppFoundation

public protocol AuctionSalesListUsecasable: Sendable {
  func fetchAuctionSales(filter: ApplyingAuctionSearchFilter?) async throws -> (auctionCount: Int?, items: [AuctionSalesItem])
  func fetchNextAuctionSales(filter: ApplyingAuctionSearchFilter?) async throws -> [AuctionSalesItem]
}
