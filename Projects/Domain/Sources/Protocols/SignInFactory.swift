//
//  SignInFactory.swift
//  Domain
//
//  Created by 송하민 on 9/16/24.
//

import Foundation

final class SignInFactory {
  func appleSigner() -> any SignInable {
    return AppleSignInManager()
  }
  
  func googleSigner() -> any SignInable {
    return AppleSignInManager()
  }
}
