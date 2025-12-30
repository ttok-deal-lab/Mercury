//
//  RecentViewListRepository.swift
//  Infrastructure
//
//  Created by 최수훈 on 12/29/25.
//

import Foundation

import AppFoundation
import Domain

public final class RecentSalesRepository: RecentSalesRepositoriable {
  
  public init() { }
  
  public func fetchRecentViewList(auctionIDs: [RecentSalesInfo]) async throws -> [RecentSalesItem] {
    let ids = auctionIDs.map { $0.id }
    let recentViewListDTO = try await AuctionAPI.auctionSales(auctionIDs: ids)
      .request([RecentSalesItemDTO].self)
    
    let recentSalesList = recentViewListDTO.map { $0.toEntity() }
    return recentSalesList
  }
}
