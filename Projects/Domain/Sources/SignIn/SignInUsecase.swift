//
//  SignInUsecase.swift
//  Domain
//
//  Created by 송하민 on 1/11/25.
//

import Foundation

import AppFoundation

public typealias SignInToken = String

public enum SignInType: String, Identifiable {
  
  public var id: String {
    return self.rawValue
  }
  
  case apple
  case google
}

public class SignInUsecase {
  
  private let factory: SignInClientFactory
  
  public init(factory: SignInClientFactory) {
    self.factory = factory
  }
  
  public func signIn(_ signInType: SignInType) async -> Result<SignInToken, MercuryError>? {
    let client = factory.makeSignInManager(for: signInType)
    return await client.signIn()
  }
  
}
