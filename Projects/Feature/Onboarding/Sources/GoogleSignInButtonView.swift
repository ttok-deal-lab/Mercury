//
//  GoogleSignInButton.swift
//  Onboarding
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import AppFoundation
import SwiftUI
//import GoogleSignIn
import ComposableArchitecture

public struct GoogleSignInButtonView: View {
  
  // MARK: - private property
  
  @Perception.Bindable private var store: StoreOf<OnboardingFeature>

  // MARK: - life cycle
  
  public init(store: StoreOf<OnboardingFeature>) {
    self.store = store
  }
  
  public var body: some View {
    ZStack {
      Button("Sign In with Google") {
        store.send(.signIn(.google))
      }
    }
  }
}
