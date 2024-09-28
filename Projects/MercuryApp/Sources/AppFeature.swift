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
    @Presents var tutorial: TutorialFeature.State?
    var path = StackState<Path.State>()
  }
  
  enum Action {
    case path(StackAction<Path.State, Path.Action>)
    case tutorial(PresentationAction<TutorialFeature.Action>)
    case destination(DestinationType)
  }
  
  enum DestinationType {
    case present(DestinationTarget)
    case push(DestinationTarget)
  }
  
  enum DestinationTarget {
    case tutorial
    case map
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .tutorial(.presented(.delegate(.tutorialCompleted))):
        state.tutorial = nil
        return .none
      case let .destination(destinationType):
        switch destinationType {
        case .present(let target):
          switch target {
          case .tutorial:
//            state.isAppFirst = false
            state.tutorial = .init()
            return .none
          case .map:
            return .none
          }
        case .push(let target):
          switch target {
          case .tutorial:
            return .none
          case .map:
            state.path.append(.map())
            return .none
          }
        }
      case .tutorial(_):
        return .none
      case .path:
        return .none
      }
    }
    .ifLet(\.$tutorial, action: \.tutorial) {
      TutorialFeature()
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
