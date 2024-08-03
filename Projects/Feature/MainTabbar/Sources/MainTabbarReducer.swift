import ComposableArchitecture

@Reducer
public struct MainTabbarReducer {
  
  public enum Tab: Equatable {
    case auction
  }
  
  public struct State: Equatable {
    public var selectedTab: Tab
    public var auctionTab: Auction.State
    
  }
  
}


@Reducer
public struct Auction {
  @ObservableState
  public struct State: Equatable {
    
  }
  
  public enum Action: Equatable {
    
  }
}
