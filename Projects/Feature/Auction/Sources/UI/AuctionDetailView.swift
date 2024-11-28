//
//  AuctionDetailView.swift
//  Auction
//
//  Created by 송하민 on 10/5/24.
//

import Coordinator
import SwiftUI

public struct AuctionDetailView: View {
  @StateObject private var store = AuctionDetailModelData()
  @EnvironmentObject private var coordinator: CoordinatorManager
  
  public init() { }
  
  public var body: some View {
    List {
      Text("Detail View")
    }
    .task {
      // TODO: - detail API
    }
  }
  
}
