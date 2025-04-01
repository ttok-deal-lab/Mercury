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

public struct SignInViewFactory<ScreenRoute: Hashable>: ViewFactory {
  private let serviceSignInUsecasable: ServiceSignInUsecasable
  private let localStorageUsecasable: LocalStorageUsecasable
  
  public init(serviceSignInUsecasable: ServiceSignInUsecasable, localStorageUsecasable: LocalStorageUsecasable) {
    self.serviceSignInUsecasable = serviceSignInUsecasable
    self.localStorageUsecasable = localStorageUsecasable
  }
  
  public func makeView(
    _ route: SignInRoute,
    eventSubject: PassthroughSubject<NavigationEvent<ScreenRoute>, Never>
  ) -> some View {
    switch route.route {
    case .signIn:
      SignInView(
        serviceSignInUsecasable: serviceSignInUsecasable,
        localStorageUsecasable: localStorageUsecasable
      )
    }
  }
}
