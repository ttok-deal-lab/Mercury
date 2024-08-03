//
//  AuctionView.swift
//  Auction
//
//  Created by 송하민 on 8/3/24.
//

import SwiftUI
import ComposableArchitecture

public struct AuctionView: View {
  
  public var store: StoreOf<AuctionReducer>
  
  public var body: some View {
    Text("Auction")
  }
  
  public init(store: StoreOf<AuctionReducer>) {
    self.store = store
  }
}
