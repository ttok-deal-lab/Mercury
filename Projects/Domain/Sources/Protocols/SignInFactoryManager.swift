//
//  SignInFactory.swift
//  Domain
//
//  Created by 송하민 on 9/16/24.
//

import Foundation

final class SignInFactoryManager {
  func appleSigner() -> any SignInable {
    return AppleSignInManager()
  }
  
  func googleSigner() -> any SignInable {
    return AppleSignInManager()
  }
}
