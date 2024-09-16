//
//  OnboardingReducer.swift
//  Onboarding
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import AppFoundation
import Domain

public enum SignInType {
  case apple
  case google
}

@Reducer
public struct OnboardingReducer {
  
  @ObservableState
  public struct State: Equatable {
    public var error: MercuryError?
    public init() { }
  }
  
  public enum Action {
    case signIn(SignInType)
    case setError(MercuryError)
    case trySignIn(SignInToken)
  }
  
  // MARK: - private property
  
  @Dependency(\.signInClient) private var signInClient
  
  
  // MARK: - life cycle
  
  public init() {
    
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .signIn(let signInType):
        switch signInType {
        case .apple:
          return .run { send in
            for await result in signInClient.appleSignIn() {
              switch result {
              case .success(let signInToken):
                print(signInToken)
                await send(.trySignIn(signInToken))
              case .failure(let error):
                await send(.setError(error))
              }
            }
          }
        case .google:
          return .run { send in
            
          }
          
        }
      case .setError(let error):
        state.error = error
        return .none
      case .trySignIn(let token):
        
        return .none
      }
    }
  }
}
