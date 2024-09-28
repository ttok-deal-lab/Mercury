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
    public var currentStep: Int = 1
    public var error: MercuryError?
    
    public init(currentStep: Int, error: MercuryError? = nil) {
      self.currentStep = currentStep
      self.error = error
    }
  }
  
  public enum Action: BindableAction, Equatable {
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
        if state.currentStep < 3 {
          state.currentStep += 1
        }
        return .none
      case .previousButtonTapped:
        if state.currentStep > 1 {
          state.currentStep -= 1
        }
        return .none
      case .completeTutorial:
        return .run { send in
          await send(.delegate(.tutorialCompleted))
        }
      case .delegate(_):
        return .none
      }
      
    }
  }
  
  
}
