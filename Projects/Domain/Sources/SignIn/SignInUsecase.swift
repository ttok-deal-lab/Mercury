//
//  SignInUsecase.swift
//  Domain
//
//  Created by 송하민 on 1/11/25.
//

import Foundation

import AppFoundation

public class SignInUsecase: SignInUsecasable {
  private let client: SignInClient
  private let factory: SignInProviderFactory
  
  public init(client: SignInClient) {
    self.client = client
    self.factory = SignInProviderFactory()
  }
  
  public func oauthSignIn(_ provider: OauthProvider) async throws -> OauthSignInToken {
    let signInProvider = factory.createProvider(provider: provider)
    return try await signInProvider.signIn()
  }
  
  public func serviceSignIn(oauthProvider: OauthProvider, oauthSignInToken: OauthSignInToken) async throws -> SignInInformation {
    return try await client
      .signIn(
        oauthProvider: oauthProvider,
        oauthSignInToken: oauthSignInToken
      )
  }
  
}


public typealias OauthSignInToken = String

public enum OauthProvider: String, Identifiable {
  public var id: String {
    return self.rawValue
  }
  case apple
  case google
//  case kakao
  case naver
}
