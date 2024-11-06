//
//  AuctionStore.swift
//  Auction
//
//  Created by 송하민 on 8/3/24.
//

import SwiftUI

import Network

public class AuctionStore: ObservableObject {
    @Published var auctions: AuctionInfo?
    
    public func fetchAuction() async throws {
        debugPrint("didTapFetch Auction")
        let auctions = try await AuctionAPI.auctionList.request(AuctionInfo.self)
        print(AuctionAPI.auctionList.baseURL)
        print(AuctionAPI.auctionList.domain)
        print(AuctionAPI.auctionList.path)
        await MainActor.run { [weak self] in
            self?.auctions = auctions
        }
    }
}
