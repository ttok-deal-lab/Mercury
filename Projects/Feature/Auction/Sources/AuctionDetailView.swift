//
//  AuctionDetailView.swift
//  Auction
//
//  Created by 송하민 on 10/5/24.
//

import SwiftUI

public struct AuctionDetailView: View {

  @StateObject private var store = AuctionStore()
  
  public init() {
    
  }
  
  public var body: some View {
    Text("Auction Detail View")
  }
  
}
