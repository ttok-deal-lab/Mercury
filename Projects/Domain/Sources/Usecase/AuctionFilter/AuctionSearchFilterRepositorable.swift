//
//  AuctionFilterRepositorable.swift
//  Domain
//
//  Created by 송하민 on 12/14/25.
//

import Foundation

public protocol AuctionSearchFilterRepositorable: Sendable {
  func fetchAuctionSearchFilters() async throws -> AuctionSearchFilter
}
