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
  
  @ObservableState
  public struct State: Equatable {
    public var selectedTab: Tab
    public var auction: AuctionReducer.State
    public var analysis: AnalysisReducer.State
    public var profile: ProfileReducer.State
    
    public init(selectedTab: Tab, auction: AuctionReducer.State, analysis: AnalysisReducer.State, profile: ProfileReducer.State) {
      self.selectedTab = selectedTab
      self.auction = auction
      self.analysis = analysis
      self.profile = profile
    }
  }
  
  public enum Action: BindableAction {
    case binding(BindingAction<State>)
    case auction(AuctionReducer.Action)
    case analysis(AnalysisReducer.Action)
    case profile(ProfileReducer.Action)
  }
  
  public init() {
    
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
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

