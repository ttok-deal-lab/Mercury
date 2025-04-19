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

public struct SignInViewFactory: ViewFactory {
  private let serviceSignInUsecasable: ServiceSignInUsecasable
  private let localStorageUsecasable: LocalStorageUsecasable
  
  public init(serviceSignInUsecasable: ServiceSignInUsecasable, localStorageUsecasable: LocalStorageUsecasable) {
    self.serviceSignInUsecasable = serviceSignInUsecasable
    self.localStorageUsecasable = localStorageUsecasable
  }
  
  public func makeView(
    _ onboardRouter: OnboardRoute,
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  ) -> some View {
    switch onboardRouter.route {
    case .signIn:
      SignInView(
        navigationStream: navigationStream,
        serviceSignInUsecasable: serviceSignInUsecasable,
        localStorageUsecasable: localStorageUsecasable
      )
    }
  }
}
