//
//  AuctionListRepositorable.swift
//  Domain
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

import AppFoundation

public protocol AuctionListRepositorable {
  func fetchAllList(courtName: String) async throws -> [AuctionItem]
}
