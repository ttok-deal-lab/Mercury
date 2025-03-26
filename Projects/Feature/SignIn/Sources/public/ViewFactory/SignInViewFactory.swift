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
  private let localStorageCLient: LocalStorageClient
  
  public init(serviceSignInUsecasable: ServiceSignInUsecasable, localStorageCLient: LocalStorageClient) {
    self.serviceSignInUsecasable = serviceSignInUsecasable
    self.localStorageCLient = localStorageCLient
  }
  
  @ViewBuilder
  public func makeView(_ signInRoute: SignInRoute) -> some View {
    switch signInRoute.route {
    case .signIn:
      SignInView(
        serviceSignInUsecasable: serviceSignInUsecasable,
        localStorageUsecasable: LocalStorageUsecase(
          localStorageClient: localStorageCLient
        )
      )
    }
  }
}
