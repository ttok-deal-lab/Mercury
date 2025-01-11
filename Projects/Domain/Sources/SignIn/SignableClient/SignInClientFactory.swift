//
//  SignInFactory.swift
//  Domain
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import AppFoundation

public final class SignInClientFactory {
  
  public init() { }
  
  public func makeSignInManager(for type: SignInType) -> SignInable {
    switch type {
    case .apple:
      return AppleSignInClient()
    case .google:
      return GoogleSignInClient()
    }
  }
  
}
