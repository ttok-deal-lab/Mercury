//
//  MainTabbarReducer.swift
//  MainTabbar
//
//  Created by 송하민 on 8/3/24.
//

import ComposableArchitecture
import Auction
import Profile
import Analysis

@Reducer
public struct MainTabbarReducer {
  
  public enum Tab: Equatable {
    case auctionTab
    case analysisTab
    case profileTab
  }
  
  public struct State: Equatable {
    public var selectedTab: Tab
    public var auction: AuctionReducer.State
    public var analysis: AnalysisReducer.State
    public var profile: ProfileReducer.State
  }
  
  public enum Action: Equatable {
    case selectTabAction(Tab)
    case auction(AuctionReducer.Action)
    case analysis(AnalysisReducer.Action)
    case profile(ProfileReducer.Action)
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .selectTabAction(tab):
        state.selectedTab = tab
        return .none
      case .auction, .analysis, .profile:
        return .none
      }
    }
    Scope(state: \.auction, action: \.auction) {
      AuctionReducer()
    }
    Scope(state: \.analysis, action: \.analysis) {
      AnalysisReducer()
    }
    Scope(state: \.profile, action: \.profile) {
      ProfileReducer()
    }
  }
  
}


// TODO: Auction 모듈로



// TODO: Anaylisis 모듈로

