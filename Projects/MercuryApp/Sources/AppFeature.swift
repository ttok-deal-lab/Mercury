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
struct AppFeature {
  
  @ObservableState
  struct State: Equatable {
    var path = StackState<Path.State>()
  }
  
  enum Action {
    case path(StackAction<Path.State, Path.Action>)
    case navigateToMap
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .path(let action):
        switch action {
        case .popFrom:
          if !state.path.isEmpty {
            _ = state.path.popLast()
          }
          return .none
        default:
          return .none
        }
      case .navigateToMap:
        state.path.append(.map())
        return .none
      }
    }
    .forEach(\.path, action: \.path) {
      Path()
    }
  }
  
}

extension AppFeature {
  
  @Reducer
  struct Path {
    
    @ObservableState
    enum State: Equatable {
      case map(MapFeature.State = .init())
    }
    
    enum Action {
      case map(MapFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
      Scope(state: \.map, action: \.map) {
        MapFeature()
      }
    }
  }
}
