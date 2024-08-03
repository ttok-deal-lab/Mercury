//
//  MainTabbarSampleView.swift
//  MainTabbar
//
//  Created by 송하민 on 8/3/24.
//

import Auction
import Analysis
import Profile
import SwiftUI
import MainTabbar
import ComposableArchitecture

struct MainTabbarSampleView: View {
  var body: some View {
    MainTabbarView(
      store: Store(
        initialState: MainTabbarReducer.State(
          selectedTab: .auctionTab,
          auction: AuctionReducer.State(),
          analysis: AnalysisReducer.State(),
          profile: ProfileReducer.State()
        )
      ) {
        MainTabbarReducer()
      }
    )
  }
}
