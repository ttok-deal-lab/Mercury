//
//  SignInFactory.swift
//  SignIn
//
//  Created by 송하민 on 1/11/25.
//

import Foundation
import SwiftUI

import Coordinator
import Domain

public struct SignInViewFactory: ViewFactory {
  private let serviceSignInUsecasable: ServiceSignInUsecasable
  private let localStorageUsecasable: LocalStorageUsecasable
  
  public init(serviceSignInUsecasable: ServiceSignInUsecasable, localStorageUsecasable: LocalStorageUsecasable) {
    self.serviceSignInUsecasable = serviceSignInUsecasable
    self.localStorageUsecasable = localStorageUsecasable
  }
  
  @ViewBuilder
  public func makeView(_ signInRoute: SignInRoute) -> some View {
    switch signInRoute.route {
    case .signIn:
      SignInView(
        serviceSignInUsecasable: serviceSignInUsecasable,
        localStorageUsecasable: localStorageUsecasable
      )
    }
  }
}
