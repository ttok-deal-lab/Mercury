//
//  SignInStore.swift
//  SignIn
//
//  Created by 송하민 on 10/4/24.
//

import Foundation
import SwiftUI
import Combine

import AppFoundation
import Domain

public final class SignInModelData: ObservableObject {
  private let signInUsecasable: SignInUsecasable
  private let localStorageUsecasable: LocalStorageUsecasable
  
  init(
    signInUsecasable: SignInUsecasable,
    localStorageUsecasable: LocalStorageUsecasable
  ) {
    self.signInUsecasable = signInUsecasable
    self.localStorageUsecasable = localStorageUsecasable
  }
  
  public func oauthSignIn(_ oauthProvider: OauthProvider) async throws {
    let oauthSignInToken = try await signInUsecasable.oauthSignIn(oauthProvider)
    try await serviceSignIn(provider: oauthProvider, oauthSignInToken: oauthSignInToken)
  }
  
  private func serviceSignIn(provider: OauthProvider, oauthSignInToken: OauthSignInToken) async throws {
    
    let signInInformation = try await signInUsecasable.serviceSignIn(oauthProvider: provider, oauthSignInToken: oauthSignInToken)
    localStorageUsecasable.setModel(signInInformation.token, forKey: .signInTokenInfo)
    localStorageUsecasable.setModel(signInInformation.user, forKey: .signInUserInfo)
  }
  
}
