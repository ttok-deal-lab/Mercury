//
//  SignInable.swift
//  Domain
//
//  Created by 송하민 on 9/16/24.
//

import Foundation

public protocol SignInable {
  func signIn() async throws -> SignInToken
}
