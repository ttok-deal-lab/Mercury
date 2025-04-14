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

public class ServiceSignInRepository: ServiceSignInRepositorable {
  
  // MARK: - private property
  
  @LazyInject private var userInformable: SignInUserInformable
  @LazyInject private var tokenInformable: SignInTokenInformable
  
  // MARK: - life cycle
  
  public init() { }
  
  // MARK: - private method
  
  private func parseToUserInfo(_ dto: SignInInformationDTO) -> ServiceSignInUserInfo {
    return .init(
      id: dto.user.id,
      email: dto.user.email,
      name: dto.user.name,
      status: ServiceSignInStatus(rawValue: dto.user.status)
    )
  }
  
  private func parseAccessToken(_ dto: SignInInformationDTO) -> UserAccessTokenInfo {
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
    
    self.userInformable.userInfo.send(serviceUserInfo)
    self.tokenInformable.tokenInfo.send(accessTokenInfo)
  }
  
}
