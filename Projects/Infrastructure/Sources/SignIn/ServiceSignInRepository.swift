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
  public init() { }
  
  public func signIn(oauthProvider: OauthProvider, oauthSignInToken: OauthSignInToken) async throws -> SignInInformation {
    let signInInformation = try await AuthAPI.signIn(
      provider: oauthProvider.rawValue,
      idToken: oauthSignInToken
    ).request(SignInInformation.self)
    
    let tokenInfoManager = MercuryContainer.shared.resolve(SignInTokenInformable.self)
    tokenInfoManager.tokenInfo.send(signInInformation.token)
    
    let userInfoManager = MercuryContainer.shared.resolve(SignInUserInformable.self)
    userInfoManager.userInfo.send(signInInformation.user)
    
    return signInInformation
  }
  
  
}
