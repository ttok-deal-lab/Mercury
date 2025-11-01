//
//  AuctionUsecasable.swift
//  Domain
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

import AppFoundation

public protocol AuctionSalesListUsecasable: Sendable {
  func fetchSalesList() async throws -> [AuctionSalesItem]
  func fetchNextSalesList() async throws -> [AuctionSalesItem]
}
