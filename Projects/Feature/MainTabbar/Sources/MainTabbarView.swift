//
//  MainTabbarView.swift
//  MainTabbar
//
//  Created by 송하민 on 8/3/24.
//

import Auction
import Analysis
import Profile
import SwiftUI
import Perception
import ComposableArchitecture

public struct MainTabbarView: View {
  @Perception.Bindable var store: StoreOf<MainTabbarReducer>
  
  public var body: some View {
    TabView(selection: $store.selectedTab) {
      AuctionView(store: store.scope(state: \.auction, action: \.auction))
        .tabItem {
          Label("Auction", systemImage: "hammer")
        }
        .tag(MainTabbarReducer.Tab.auctionTab)
      
      AnalysisView(store: store.scope(state: \.analysis, action: \.analysis))
        .tabItem {
          Label("Analysis", systemImage: "chart.bar")
        }
        .tag(MainTabbarReducer.Tab.analysisTab)
      
      ProfileView(store: store.scope(state: \.profile, action: \.profile))
        .tabItem {
          Label("Profile", systemImage: "person")
        }
        .tag(MainTabbarReducer.Tab.profileTab)
    }
  }
  
  public init(store: StoreOf<MainTabbarReducer>) {
    self.store = store
  }
}
