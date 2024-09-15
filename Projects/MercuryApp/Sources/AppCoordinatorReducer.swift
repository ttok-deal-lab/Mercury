//
//  AppCoordinator.swift
//  MercuryApp
//
//  Created by 송하민 on 8/30/24.
//

import Map
import Foundation
import ComposableArchitecture

@Reducer
struct AppCoordinatorReducer {
  
  @ObservableState
  struct State: Equatable {
    var path = StackState<Path.State>()
  }
  
  enum Action {
    case path(StackAction<Path.State, Path.Action>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .path(stackAction):
        switch stackAction {
        case .element(id: _, action: .mapAction(.setDrawMap(true))):
          state.path.append(.mapState())
          return .none
        default:
          return .none
        }
      }
    }
  }
  
}

extension AppCoordinatorReducer {
  
  @Reducer
  struct Path {
    
    @ObservableState
    enum State: Equatable {
      case mapState(MapReducer.State = .init())
    }
    
    enum Action {
      case mapAction(MapReducer.Action)
    }
    
    var body: some ReducerOf<Self> {
      Scope(state: \.mapState, action: \.mapAction) {
        MapReducer()
      }
    }
  }
}
