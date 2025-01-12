//
//  SignInFactory.swift
//  Domain
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import AppFoundation

public final class SignInProviderFactory {
  
  public init() { }
  
  public func makeSignInManager(provider: OauthProvider) -> SignInable {
    switch type {
    case .apple:
      return AppleSignInProvider()
    case .google:
      return GoogleSignInProvider()
    }
  }
  
}
