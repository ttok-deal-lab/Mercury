//
//  ContnetView.swift
//  AppleSignInSampleApp
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import SwiftUI
import Onboarding
import ComposableArchitecture

struct ContentView: View {
  var body: some View {
    VStack {
      AppleSignInButtonView(store: Store(initialState: OnboardingFeature.State(), reducer: {
        OnboardingFeature()
      }))
      GoogleSignInButtonView(store: Store(initialState: OnboardingFeature.State(), reducer: {
        OnboardingFeature()
      }))
    }
  }
}
