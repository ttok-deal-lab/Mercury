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
  
  public init(signInClient: SignInClient) {
    self.signInClient = signInClient
  }
  
  @ViewBuilder
  public func makeView(_ signInRoute: SignInRoute) -> some View {
    switch signInRoute.route {
    case .signIn:
      SignInView(
        signInUsecase: SignInUsecase(
          client: signInClient,
          factory: SignInProviderFactory()
        )
      )
    }
  }
}
