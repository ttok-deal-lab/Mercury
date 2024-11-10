//
//  AuctionView.swift
//  Auction
//
//  Created by 송하민 on 8/3/24.
//

import SwiftUI

public struct AuctionListView: View {
  
  @StateObject private var store = AuctionModelData()
  
  public var body: some View {
    VStack {
      List(store.auctions ?? [], id: \.id) { auction in
        AuctionRow(auctionInfo: auction)
      }
      .listStyle(.plain)
      .task {
        do {
          try await store.fetchAuction()
        } catch {
          print(error)
        }
      }
      
      Button("Button") {
        Task {
          try await store.fetchAuction()
        }
      }
    }
  } // body
  
}
