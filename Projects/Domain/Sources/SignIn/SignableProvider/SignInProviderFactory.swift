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
  
  public func createProvider(provider: OauthProvider) -> SignInable {
    switch provider {
    case .apple:
      return AppleSignInProvider()
    case .google:
      return GoogleSignInProvider()
    case .naver:
      return NaverSignInProvider()
    }
  }
  
}
