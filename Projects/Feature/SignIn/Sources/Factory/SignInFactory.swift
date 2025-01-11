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

public struct SignInFactory {
  
  @ViewBuilder
  public static func makeView(_ signInRoute: SignInRoute) -> some View {
    switch signInRoute.route {
    case .signIn:
      SignInView(
        signInUsecase: SignInUsecase(
          factory: SignInClientFactory()
        )
      )
    }
  }
}
