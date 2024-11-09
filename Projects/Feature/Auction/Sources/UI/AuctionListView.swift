//
//  AuctionView.swift
//  Auction
//
//  Created by 송하민 on 8/3/24.
//

import SwiftUI

@MainActor
public struct AuctionListView: View {
    
    @StateObject private var store = AuctionStore()
    
    var nums = Array(repeating: 1, count: 5)
    public init() { }
    public var body: some View {
        VStack {
            List(store.auctions ?? []) { auction in
                AuctionRow(auctionInfo: auction)
            }
            .listStyle(.plain)
            .onAppear {
                Task {
                    try await store.fetchAuction()
                }
            }
            
            Button("Butrton") {
                Task {
                    try await self.store.fetchAuction()
                }
            }
        }
    } // body

}
