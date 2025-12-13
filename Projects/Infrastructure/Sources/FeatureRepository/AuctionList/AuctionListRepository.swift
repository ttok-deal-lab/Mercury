//
//  AuctionSalesListRepository.swift
//  Infrastructure
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

import AppFoundation
import Domain

public final class AuctionSalesListRepository: AuctionSalesListRepositorable {
  
  public init() {
    
  }
  
  public func fetchAuctionSales(cursor: String?, size: Int) async throws -> AuctionSales {
    let auctionSalesItemDTO = try await AuctionAPI.auctionSearchList(
      keyword: nil,
      region: nil,
      district: nil,
      buildType: nil,
      auctionFailCount: nil,
      varificationStatus: nil,
      minimumPrice: nil,
      maximumPrice: nil,
      nextCursor: cursor,
      sort: nil
    ).request(AuctionSalesDTO.self)
    let auctionItems = auctionSalesItemDTO.toEntity()
    return auctionItems
  }
}

