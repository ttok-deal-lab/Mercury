//
//  SignInClientLive.swift
//  SignIn
//
//  Created by 송하민 on 10/4/24.
//

import Foundation
import AppFoundation

class SignInClientLive: SignInClient {
  
  // MARK: - private property
  
  private let factory = SignInClientFactory()
  
  // MARK: - life cycle
  
  init() {
    
  }
  
  // MARK: - private method
  
  // MARK: - method
  
  func signIn(type: SignInType) async -> Result<SignInToken, MercuryError>? {
    return await self.factory.signIn(type: type)
  }
  
  
}
