//
//  AuctionView.swift
//  Auction
//
//  Created by 송하민 on 8/3/24.
//

import SwiftUI

public struct AuctionListView: View {

  @StateObject private var store = AuctionStore()
  
  public var body: some View {
    Text("Auction")
  }
  
}
