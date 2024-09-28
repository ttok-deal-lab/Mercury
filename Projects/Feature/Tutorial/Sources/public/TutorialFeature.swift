//
//  TutorialFeature.swift
//  Tutorial
//
//  Created by 송하민 on 9/28/24.
//

import Foundation
import AppFoundation
import ComposableArchitecture
import Service

@Reducer
public struct TutorialFeature {
  
  @ObservableState
  public struct State: Equatable {
    public var error: MercuryError?
    var path = StackState<Path.State>()
    
    public init(error: MercuryError? = nil) {
      self.error = error
    }
    
  }
  
  public enum Action: BindableAction, Equatable {
    case path(StackAction<Path.State, Path.Action>)
    case binding(BindingAction<State>)
    case setError(MercuryError)
    case nextButtonTapped
    case previousButtonTapped
    case completeTutorial
    case delegate(DelegateAction)
  }
  
  public enum DelegateAction: Equatable {
    case tutorialCompleted
  }
  
  // MARK: - private property
  
  
  // MARK: - life cycle
  
  public init() {
    
  }
  
  public var body: some ReducerOf<Self> {
    BindingReducer()
    Reduce { state, action in
      switch action {
      case .binding(_):
        return .none
      case .setError(let error):
        state.error = error
        return .none
      case .nextButtonTapped:
        guard let lastStep = state.path.last else {
          state.path.append(.step2)
          return .none
        }
        switch lastStep {
        case .step1:
          state.path.append(.step2)
        case .step2:
          state.path.append(.step3)
        default:
          return .none
        }
        return .none
      case .previousButtonTapped:
        guard !state.path.isEmpty else { return .none }
        _ = state.path.popLast()
        return .none
      case .completeTutorial:
        return .run { send in
          await send(.delegate(.tutorialCompleted))
        }
      case .delegate(_):
        return .none
      case .path(_):
        return .none
      }
    }
    .forEach(\.path, action: \.path) {
      Path()
    }
   
  }
}
