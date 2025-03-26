//
//  SignInable.swift
//  Domain
//
//  Created by 송하민 on 9/16/24.
//

import Foundation

import AppFoundation
import Domain

public protocol OauthSignInable {
  func signIn() async throws -> OauthSignInToken
}
