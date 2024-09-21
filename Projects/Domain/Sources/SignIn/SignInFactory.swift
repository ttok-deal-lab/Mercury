//
//  SignInFactory.swift
//  Domain
//
//  Created by 송하민 on 9/16/24.
//

import Foundation

public final class SignInFactory {
  
  // MARK: - private property
  
  // MARK: - public property
  
  // MARK: - life cycle
  
  public init() { }
  
  // MARK: - private method
  
  // MARK: - public method
  
  public func appleSigner() -> any SignInable {
    return AppleSignInManager()
  }
  
  public func googleSigner() -> any SignInable {
    return GoogleSignInManager()
  }
}
