//
//  AuctionStore.swift
//  Auction
//
//  Created by 송하민 on 8/3/24.
//

import SwiftUI

import Network

public class AuctionStore: ObservableObject {
    @Published var auctions: [AuctionInfo]?
    
    public func fetchAuction() async throws {
        debugPrint("didTapFetch Auction")
        
        let api = AuctionAPI.auctionList(
            "LAND",
            mediumCategory: "LAND_LAND",
            page: 1
        )
        let auctions = try await api.requestWithParm([AuctionInfo].self)
        await MainActor.run { [weak self] in
            self?.auctions = auctions
        }
    }
}
