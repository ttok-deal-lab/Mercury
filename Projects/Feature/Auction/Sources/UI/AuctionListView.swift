//
//  AuctionView.swift
//  Auction
//
//  Created by 송하민 on 8/3/24.
//

import Coordinator
import SwiftUI

public struct AuctionListView: View {
  @StateObject private var store = AuctionModelData()
  @EnvironmentObject private var coordinator: CoordinatorManager
  
  public init() {}
  public var body: some View {
    VStack {
      List(store.auctions ?? [], id: \.id) { auction in
        AuctionRow(auctionInfo: auction)
          .onTapGesture {
            coordinator.push(page: .auction(.detail))
          }
      }
      .listStyle(.plain)
      .task {
        do {
          try await store.fetchAuction()
        } catch {
          // TODO: - UI Error 처리
          print("‼️‼️ Error: ", error)
        }
      }
    }
  }// body
}
