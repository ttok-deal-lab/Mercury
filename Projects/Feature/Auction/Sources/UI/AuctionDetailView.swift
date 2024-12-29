//
//  AuctionDetailView.swift
//  Auction
//
//  Created by 송하민 on 10/5/24.
//

import SwiftUI

import Coordinator

struct AuctionDetailView: View {
  @EnvironmentObject private var coordinator: GlobalCoordinator<GlobalRoute>
  @StateObject private var store = AuctionModelData()
  
  var auctionId: Int
  
  var body: some View {
    Text("Auction Detail. Id: \(auctionId)")
    
    Button {
      // 이런식으로도 가능
      coordinator.dismissFullScreen()
      coordinator.pop()
    } label: {
      Text("close")
    }

  }
  
}
