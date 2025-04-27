//
//  SignInClient.swift
//  Infrastructure
//
//  Created by 송하민 on 1/12/25.
//

import Foundation

import AppFoundation
import Domain
import Networking

public final class ServiceSignInRepository: ServiceSignInRepositorable {
  @LazyInject private var userInfoManager: UserInfoManagable
  @LazyInject private var accessTokenManager: AccessTokenManagable
  
  public init() { }
  
  public func signIn(oauthProvider: OauthProvider, oauthSignInToken: OauthSignInToken) async throws {
    let userInfoDTO = try await AuthAPI.signIn(
      provider: oauthProvider.rawValue,
      idToken: oauthSignInToken
    ).request(UserInfoDTO.self)
    self.userInfoManager.setUserInfo(userInfoDTO.toUserInformation())
    self.accessTokenManager.setAccessToken(userInfoDTO.toUserAccessToken())
  }
  
}
