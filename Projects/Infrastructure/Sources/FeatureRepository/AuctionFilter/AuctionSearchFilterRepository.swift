//
//  AuctionFilterRepository.swift
//  Infrastructure
//
//  Created by 송하민 on 12/14/25.
//

import Foundation

import Domain

public final class AuctionSearchFilterRepository: AuctionSearchFilterRepositorable {
  
  public init() { }
  
  public func fetchAuctionSearchFilters() async throws -> AuctionSearchFilter {
    let auctionSearchFilterDTO = try await AuctionAPI.auctionSearchFilter.request(AuctionSearchFilterDTO.self)
    return auctionSearchFilterDTO.toEntity()
  }
  
  
}
