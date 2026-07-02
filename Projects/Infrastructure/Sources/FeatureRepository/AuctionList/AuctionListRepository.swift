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
  
  public func fetchAuctionSales(
    filter: CurrentAuctionFilter?,
    cursor: String?,
    size: Int
  ) async throws -> AuctionSales {
    let auctionSalesItemDTO = try await AuctionAPI.auctionSearchList(
      keyword: filter?.keyword,
      region: filter?.region?.code,
      district: filter?.district?.code,
      buildTypes: filter?.buildingTypeCodes.map { Array($0) },
      auctionFailCount: filter?.auctionFailCodes.map { Array($0) },
      isCertified: filter?.isCertified,
      minimumPrice: filter?.minimumPrice,
      maximumPrice: filter?.maximumPrice,
      nextCursor: cursor,
      sort: filter?.sort?.code,
      size: size
    ).request(AuctionSalesDTO.self)
    let auctionItems = auctionSalesItemDTO.toEntity()
    return auctionItems
  }
}

