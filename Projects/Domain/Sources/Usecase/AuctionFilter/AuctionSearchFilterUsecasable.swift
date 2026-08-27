//
//  KoreaLocationUsecasable.swift
//  Domain
//
//  Created by 송하민 on 12/14/25.
//

import Foundation

import AppFoundation

public protocol AuctionSearchFilterUsecasable: Sendable {
  func fetchAuctionSearchFilters() async throws -> AuctionSearchFilter
}

