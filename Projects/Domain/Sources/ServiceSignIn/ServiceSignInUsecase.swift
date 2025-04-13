//
//  SignInUsecase.swift
//  Domain
//
//  Created by 송하민 on 1/11/25.
//

import Foundation

import AppFoundation

public class ServiceSignInUsecase: ServiceSignInUsecasable {
  private let repository: ServiceSignInRepositorable
  
  public init(repository: ServiceSignInRepositorable) {
    self.repository = repository
  }
  
  public func serviceSignIn(oauthProvider: OauthProvider, oauthSignInToken: OauthSignInToken) async throws -> ServiceSignInUserInfo {
    return try await repository.signIn(
      oauthProvider: oauthProvider,
      oauthSignInToken: oauthSignInToken
    )
  }
}


public typealias OauthSignInToken = String

public enum OauthProvider: String, Identifiable, CaseIterable {
  public var id: String {
    return self.rawValue
  }
  case apple
  case google
  case kakao
  case naver
}
