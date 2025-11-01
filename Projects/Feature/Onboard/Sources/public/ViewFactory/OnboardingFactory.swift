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
  private let serviceSignInUsecasable: ServiceSignInUsecasable
  private let locationUsecasable: LocationUsecasable
  
  public init(
    serviceSignInUsecasable: ServiceSignInUsecasable,
    locationUsecasable: LocationUsecasable
  ) {
    self.serviceSignInUsecasable = serviceSignInUsecasable
    self.locationUsecasable = locationUsecasable
  }
  
  public func makeView(
    _ onboardRouter: OnboardRoute,
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  ) -> some View {
    switch onboardRouter.route {
    case .permissionRequest:
      PermissionRequestView(
        modelData: OnboardingModelData(serviceSignInUsecasable: self.serviceSignInUsecasable, locationUsecasable: self.locationUsecasable),
        navigationStream: navigationStream
      )
    }
  }
}
