//
//  SignInUsecasable.swift
//  Domain
//
//  Created by 송하민 on 1/12/25.
//

import Foundation

import AppFoundation

public protocol SignInUsecasable {
  func oauthSignIn(_ provider: OauthProvider) async throws -> OauthSignInToken
  func serviceSignIn(oauthProvider: OauthProvider, oauthSignInToken: OauthSignInToken) async throws -> SignInInformation
}
