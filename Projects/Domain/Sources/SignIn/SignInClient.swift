//
//  SignInClient.swift
//  Domain
//
//  Created by 송하민 on 1/12/25.
//


import Foundation

import AppFoundation

public protocol SignInClient {
  func signIn(oauthProvider: OauthProvider, oauthSignInToken: OauthSignInToken) async throws -> SignInInformation
}
