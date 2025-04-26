//
//  SignInClient.swift
//  Infrastructure
//
//  Created by 송하민 on 1/12/25.
//

import Foundation

import AppFoundation
import Domain
import Network

public final class ServiceSignInRepository: ServiceSignInRepositorable {
  
  // MARK: - private property
  
  @LazyInject private var userInfoManager: UserInfoManagable
  @LazyInject private var accessTokenManager: AccessTokenManagable
  
  // MARK: - life cycle
  
  public init() { }
  
  // MARK: - private method
  
  private func parseToUserInfo(_ dto: SignInInformationDTO) -> UserInformation {
    return .init(
      id: dto.user.id,
      email: dto.user.email,
      name: dto.user.name,
      status: ServiceSignInStatus(rawValue: dto.user.status)
    )
  }
  
  private func parseAccessToken(_ dto: SignInInformationDTO) -> UserAccessToken {
    return .init(accessToken: dto.token.accessToken)
  }
  
  // MARK: - public method
  
  public func signIn(oauthProvider: OauthProvider, oauthSignInToken: OauthSignInToken) async throws {
    let resultInfo = try await AuthAPI.signIn(
      provider: oauthProvider.rawValue,
      idToken: oauthSignInToken
    ).request(SignInInformationDTO.self)
    
    let serviceUserInfo = parseToUserInfo(resultInfo)
    let accessTokenInfo = parseAccessToken(resultInfo)
    self.userInfoManager.setUserInfo(serviceUserInfo)
    self.accessTokenManager.setAccessToken(accessTokenInfo)
  }
  
}
