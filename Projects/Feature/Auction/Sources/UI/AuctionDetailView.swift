//
//  AuctionDetailView.swift
//  Auction
//
//  Created by 송하민 on 10/5/24.
//

import SwiftUI

import Router

struct AuctionDetailView: View {
  @StateObject private var store = AuctionModelData()
  
  var auctionId: Int
  
  var body: some View {
    Text("Auction Detail. Id: \(auctionId)")
    
    Button {
    
    } label: {
      Text("close")
    }
  }
}
