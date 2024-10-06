//
//  SignInFactory.swift
//  Domain
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import AppFoundation

public final class SignInClientFactory {
  
  // MARK: - private property
  
  // MARK: - public property
  
  // MARK: - life cycle
  
  public init() { }
  
  // MARK: - private method
  
  @MainActor private func makeSignInManager(for type: SignInType) -> SignInable {
    switch type {
    case .apple:
      return AppleSignInManager()
    case .google:
      return GoogleSignInManager()
    }
  }
  
  // MARK: - public method
  
  public func signIn(type: SignInType) async -> Result<SignInToken, MercuryError>? {
    let manager = await makeSignInManager(for: type)
    return await manager.signIn()
  }
}
