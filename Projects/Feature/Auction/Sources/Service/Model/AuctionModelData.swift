//
//  AuctionStore.swift
//  Auction
//
//  Created by 송하민 on 8/3/24.
//

import SwiftUI

import Network

public class AuctionModelData: ObservableObject {
  @Published var auctions: [AuctionList]?
  
  public func fetchAuction() async throws {
    let api = AuctionAPI.auctionList(
      "LAND",
      mediumCategory: "LAND_LAND",
      page: 1
    )
    
    let auctions = try await api.request([AuctionList].self)
    await MainActor.run { [weak self] in
      self?.auctions = auctions
    }
  }
}
