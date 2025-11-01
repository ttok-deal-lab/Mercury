//
//  SignInUsecasable.swift
//  Domain
//
//  Created by 송하민 on 1/12/25.
//

import Foundation

import AppFoundation

public protocol ServiceSignInUsecasable: Sendable {
  func serviceSignIn(oauthProvider: OauthProvider, oauthSignInToken: OauthSignInToken) async throws
}
