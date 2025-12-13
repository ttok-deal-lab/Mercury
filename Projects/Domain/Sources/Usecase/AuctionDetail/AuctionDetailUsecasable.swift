//
//  AuctionDetailUsecasable.swift
//  Domain
//
//  Created by 송하민 on 11/1/25.
//

import Foundation

import AppFoundation

public protocol AuctionDetailUsecasable: Sendable {
  func fetchAuctionDetail(auctionID: Int) async throws -> AuctionDetail
}
