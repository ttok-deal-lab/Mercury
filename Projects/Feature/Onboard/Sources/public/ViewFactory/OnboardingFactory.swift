//
//  SignInFactory.swift
//  SignIn
//
//  Created by 송하민 on 1/11/25.
//

import Foundation
import SwiftUI
import Combine

import Router
import Domain

public struct OnboardingFactory: ViewFactory {
  
  public init() {
    
  }
  
  public func makeView(
    _ onboardRouter: OnboardRoute,
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  ) -> some View {
    EmptyView()
  }
}
