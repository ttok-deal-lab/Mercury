//
//  SignInClient.swift
//  SignIn
//
//  Created by 송하민 on 10/4/24.
//

import Foundation
import AppFoundation

public typealias SignInToken = String

public enum SignInType {
  case apple
  case google
}

public protocol SignInClient {
  func signIn(type: SignInType) async -> Result<SignInToken, MercuryError>?
}
