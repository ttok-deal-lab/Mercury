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

final class OnboardingModelData: ObservableObject {
  @Published var isLoading: Bool = false
  
  private let serviceSignInUsecasable: ServiceSignInUsecasable
  private let oauthSignInProviderFactory = SignInProviderFactory()
  
  init(
    serviceSignInUsecasable: ServiceSignInUsecasable
  ) {
    self.serviceSignInUsecasable = serviceSignInUsecasable
  }
  
  @MainActor
  private func setLoading(_ value: Bool) {
    self.isLoading = value
  }
  
  private func serviceSignIn(provider: OauthProvider, oauthSignInToken: OauthSignInToken) async throws {
    await setLoading(true)
    do {
      try await serviceSignInUsecasable.serviceSignIn(
        oauthProvider: provider,
        oauthSignInToken: oauthSignInToken
      )
    } catch {
      await setLoading(false)
      throw error
    }
    await setLoading(false)
  }
  
  func oauthSignIn(_ oauthProvider: OauthProvider) async throws {
    let signInProvider = oauthSignInProviderFactory.createProvider(provider: oauthProvider)
    let oauthSignInToken = try await signInProvider.signIn()
    try await serviceSignIn(provider: oauthProvider, oauthSignInToken: oauthSignInToken)
  }
}
