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
  
  @EnvironmentObject var coordinator: CoordinatorManager
  //  @StateObject var coordinator = CoordinatorManager()
  
  var body: some View {
    NavigationStack(path: $coordinator.path) {
      AuctionCoordinatorFactory(page: AppPage.auction(.list))
        .navigationDestination(for: AppPage.self) { page in
          AuctionCoordinatorFactory(page: page)
        }
        .sheet(item: $coordinator.sheet) { page in
          AuctionCoordinatorFactory(page: page)
        }
        .fullScreenCover(item: $coordinator.fullScreenCover) { page in
          NavigationStack(path: $coordinator.fullScreenCoverPath) {
            AuctionCoordinatorFactory(page: page)
              .navigationDestination(for: AppPage.self) { page in
                AuctionCoordinatorFactory(page: page)
              }
          }
        }
    }
    //    NavigationStack(path: $coordinator.fullScreenCoverPath) {
    //      AuctionListView()
    //    }
    //    .environmentObject(coordinator)
  }
}

struct AuctionCoordinatorFactory: View {
  @EnvironmentObject var coordinator: CoordinatorManager
  
  let page: AppPage
  
  var body: some View {
    build(page: page)
  }
  @ViewBuilder
  func build(page: AppPage) -> some View {
    switch page {
    case .auction(let auction):
      switch auction {
        
      case .list:
        AuctionListView().environmentObject(coordinator)
      case .detail:
        AuctionDetailView().environmentObject(coordinator)
      }
    case .tutorial(let tutorials):
      EmptyView()
    case .map:
      EmptyView()
    }
  }
}
