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
  private let serviceSignInUsecasable: ServiceSignInUsecasable
  private let localStorageUsecasable: LocalStorageUsecasable
  private let oauthSignInProviderFactory = SignInProviderFactory()
  
  init(
    serviceSignInUsecasable: ServiceSignInUsecasable,
    localStorageUsecasable: LocalStorageUsecasable
  ) {
    self.serviceSignInUsecasable = serviceSignInUsecasable
    self.localStorageUsecasable = localStorageUsecasable
  }
  
  private func serviceSignIn(provider: OauthProvider, oauthSignInToken: OauthSignInToken) async throws {
    let signInInformation = try await serviceSignInUsecasable.serviceSignIn(oauthProvider: provider, oauthSignInToken: oauthSignInToken)
    localStorageUsecasable.setModel(signInInformation, forKey: .signInTokenInfo)
  }
  
  public func oauthSignIn(_ oauthProvider: OauthProvider) throws {
    Task {
      let signInProvider = oauthSignInProviderFactory.createProvider(provider: oauthProvider)
      let oauthSignInToken = try await signInProvider.signIn()
      try await serviceSignIn(provider: oauthProvider, oauthSignInToken: oauthSignInToken)
    }
  }
}
