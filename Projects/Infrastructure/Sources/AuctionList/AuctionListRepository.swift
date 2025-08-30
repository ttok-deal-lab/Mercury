//
//  AuctionListRepository.swift
//  Infrastructure
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

import AppFoundation
import Domain

public final class AuctionListRepository: AuctionListRepositorable {
  
  public init() {
    
  }
  
  public func fetchAllSalesList() async throws -> [AuctionItem] {
    let auctionItemDTOs = try await AuctionAPI.auctionList.request([AuctionItemDTO].self)
    let auctionItems = auctionItemDTOs.map { $0.toAuctionItem() }
    return auctionItems
  }
}
