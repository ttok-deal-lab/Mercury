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

public class SignInRemoteClient: SignInClient {
  public init() { }
  
  public func signIn(oauthProvider: OauthProvider, oauthSignInToken: OauthSignInToken) async throws -> SignInInformation {
    let signInResult = try await AuthAPI.signIn(provider: oauthProvider.rawValue, idToken: oauthSignInToken).request(SignInInformation.self)
    print("signin result ~> \(signInResult)")
    
    return signInResult
  }
  
  
}
