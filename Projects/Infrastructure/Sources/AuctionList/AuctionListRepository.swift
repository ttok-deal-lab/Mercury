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
  
  public func fetchAllSalesList() async throws -> AuctionSales {
    let auctionSalesItemDTO = try await AuctionAPI.auctionList.request(AuctionSalesDTO.self)
    let auctionItems = auctionSalesItemDTO.toEntity()
    return auctionItems
  }
}
