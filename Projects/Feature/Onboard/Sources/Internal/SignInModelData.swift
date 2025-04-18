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

@Observable
final class SignInModelData {

  // MARK: - private proprty

  private let serviceSignInUsecasable: ServiceSignInUsecasable
  private let localStorageUsecasable: LocalStorageUsecasable
  private let oauthSignInProviderFactory = SignInProviderFactory()
  

  // MARK: - life cycle
  
  init(
    serviceSignInUsecasable: ServiceSignInUsecasable,
    localStorageUsecasable: LocalStorageUsecasable
  ) {
    self.serviceSignInUsecasable = serviceSignInUsecasable
    self.localStorageUsecasable = localStorageUsecasable
  }
  
  // MARK: - private method
  
  private func serviceSignIn(provider: OauthProvider, oauthSignInToken: OauthSignInToken) async throws {
    try await serviceSignInUsecasable.serviceSignIn(oauthProvider: provider, oauthSignInToken: oauthSignInToken)
  }
  
  // MARK: - public method
  
  func oauthSignIn(_ oauthProvider: OauthProvider) async throws {
    let signInProvider = oauthSignInProviderFactory.createProvider(provider: oauthProvider)
    let oauthSignInToken = try await signInProvider.signIn()
    try await serviceSignIn(provider: oauthProvider, oauthSignInToken: oauthSignInToken)
  }
}
