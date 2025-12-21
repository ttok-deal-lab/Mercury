//
//  AuctionSalesListRepositorable.swift
//  Domain
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

import AppFoundation

public protocol AuctionSalesListRepositorable: Sendable {
  func fetchAuctionSales(
    filter: ApplyingAuctionSearchFilter?,
    cursor: String?,
    size: Int
  ) async throws -> AuctionSales
}
