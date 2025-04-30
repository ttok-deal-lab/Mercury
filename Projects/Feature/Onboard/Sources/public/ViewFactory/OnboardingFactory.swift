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
  private let modelData: OnboardingModelData
  
  public init(modelData: OnboardingModelData) {
    self.modelData = modelData
  }
  
  public func makeView(
    _ onboardRouter: OnboardRoute,
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  ) -> some View {
    switch onboardRouter.route {
    case .permissionRequest:
      PermissionRequestView(modelData: modelData, navigationStream: navigationStream)
    }
  }
}
