//
//  RecentViewListRepositoriable.swift
//  Infrastructure
//
//  Created by 최수훈 on 12/29/25.
//

import Foundation

import AppFoundation

public protocol RecentSalesRepositoriable: Sendable {
  func fetchRecentViewList(auctionIDs: [RecentSalesInfo]) async throws -> [RecentSalesItem]
}
