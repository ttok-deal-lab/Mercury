//
//  AppCoordinator.swift
//  MercuryApp
//
//  Created by 송하민 on 8/30/24.
//

import Map
import Tutorial
import Foundation
import ComposableArchitecture

@Reducer
struct AppFeature {
  
  @ObservableState
  struct State: Equatable {
    @Shared(.appStorage("isAppFirst")) var isAppFirst = true
    var path = StackState<Path.State>()
  }
  
  enum Action {
    case path(StackAction<Path.State, Path.Action>)
    case navigateToTutorial
    case navigateToMap
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .path(.element(id: _, action: .tutorial(.delegate(.tutorialCompleted)))):
        state.path.removeAll()
        return .none
      case .path:
        return .none
      
      case .navigateToTutorial:
//        state.isAppFirst = false
        state.path.append(.tutorial(TutorialFeature.State(currentStep: 1)))
        return .none
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
      case tutorial(TutorialFeature.State)
      case map(MapFeature.State = .init())
    }
    
    enum Action {
      case tutorial(TutorialFeature.Action)
      case map(MapFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
      Scope(state: \.tutorial, action: \.tutorial) {
        TutorialFeature()
      }
      Scope(state: \.map, action: \.map) {
        MapFeature()
      }
    }
  }
}
