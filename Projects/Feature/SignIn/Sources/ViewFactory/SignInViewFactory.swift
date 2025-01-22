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

public struct SignInViewFactory {
  private let signInClient: SignInClient
  private let localStorageCLient: LocalStorageClient
  
  public init(signInClient: SignInClient, localStorageCLient: LocalStorageClient) {
    self.signInClient = signInClient
    self.localStorageCLient = localStorageCLient
  }
  
  @ViewBuilder
  public func makeView(_ signInRoute: SignInRoute) -> some View {
    switch signInRoute.route {
    case .signIn:
      SignInView(
        signInUsecasable: SignInUsecase(
          client: signInClient
        ),
        localStorageUsecasable: LocalStorageUsecase(
          localStorageClient: localStorageCLient
        )
      )
    }
  }
}
