//
//  SignInUsecase.swift
//  Domain
//
//  Created by 송하민 on 1/11/25.
//

import Foundation

import AppFoundation

public typealias OauthSignInToken = String

public enum OauthProvider: String, Identifiable {
  
  public var id: String {
    return self.rawValue
  }
  
  case apple
  case google
}

public class SignInUsecase {
  
  private let factory: SignInProviderFactory
  
  public init(factory: SignInProviderFactory) {
    self.factory = factory
  }
  
  public func signIn(_ provider: OauthProvider) async throws -> OauthSignInToken {
    let signInProvider = factory.makeSignInManager(provider: provider)
    return try await signInProvider.signIn()
  }
  
}
