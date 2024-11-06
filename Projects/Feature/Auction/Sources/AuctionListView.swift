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
 
    public init() {
        
    }
    var nums = Array(repeating: 1, count: 5)
    public var body: some View {
        VStack {
            List {
                ForEach(nums, id: \.self) { num in
                    Text("\(num)")
                }
            }
            .background(.green)
            
            Button("Butrton") {
                Task {
                    try await self.fetchauction()
                }
            }
        
        }
    } // body
    
    func fetchauction() async throws {
        try await store.fetchAuction()
    }
    
}
