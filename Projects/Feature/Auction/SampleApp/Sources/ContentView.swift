//
//  ContentView.swift
//  AuctionSampleApp
//
//  Created by 최수훈 on 11/6/24.
//

import Foundation
import SwiftUI

import Auction
import Coordinator

struct ContentView: View {
  
  @StateObject var coordinator = CoordinatorManager()
  
  var body: some View {
    NavigationStack(path: $coordinator.path) {
      AuctionListView()
    }
    .environmentObject(coordinator)
  }
}
