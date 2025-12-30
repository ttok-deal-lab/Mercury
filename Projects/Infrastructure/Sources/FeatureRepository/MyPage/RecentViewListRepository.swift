//
//  RecentViewListRepository.swift
//  Infrastructure
//
//  Created by 최수훈 on 12/29/25.
//

import Foundation

import AppFoundation
import Domain

public final class RecentViewListRepository: RecentViewListRepositoriable {
  
  public init() { }
  
  public func fetchRecentViewList(auctionIDs: [RecentSalesInfo]) async throws -> [RecentViewSalesItem] {
    let ids = auctionIDs.map { $0.id }
    let recentViewListDTO = try await AuctionAPI.auctionSales(auctionIDs: ids)
      .request([RecentViewSalesDTO].self)
    
    let recentSalesList = recentViewListDTO.map { $0.toEntity() }
    return recentSalesList
  }
}
