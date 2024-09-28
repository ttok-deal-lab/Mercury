//
//  AppleSignInButton.swift
//  Onboarding
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture


public struct AppleSignInButtonView: View {
  
  // MARK: - private property
  
  @Perception.Bindable private var store: StoreOf<OnboardingFeature>
  
  // MARK: - life cycle
  
  public init(store: StoreOf<OnboardingFeature>) {
    self.store = store
  }
  
  public var body: some View {
    Button {
      store.send(.signIn(.apple))
    } label: {
      HStack {
        Image(systemName: "applelogo")
        Text("Continue with Apple")
      }
      .padding()
      .background(.black)
      .foregroundStyle(.white)
      .clipShape(RoundedRectangle(cornerRadius: 8))
    }
  }
}
