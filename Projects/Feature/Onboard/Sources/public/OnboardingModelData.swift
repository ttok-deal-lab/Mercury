//
//  SignInStore.swift
//  SignIn
//
//  Created by 송하민 on 10/4/24.
//

import Foundation
import SwiftUI
import Combine
import CoreLocation

import AppFoundation
import Domain

@Observable
public final class OnboardingModelData {
  var isLoading: Bool = false
  
  private let serviceSignInUsecasable: ServiceSignInUsecasable
  private let locationUsecasable: LocationUsecasable
  private let oauthSignInProviderFactory: SignInProviderFactory
  
  public init(
    serviceSignInUsecasable: ServiceSignInUsecasable,
    locationUsecasable: LocationUsecasable,
    oauthSignInProviderFactory: SignInProviderFactory = SignInProviderFactory()
  ) {
    self.serviceSignInUsecasable = serviceSignInUsecasable
    self.locationUsecasable = locationUsecasable
    self.oauthSignInProviderFactory = oauthSignInProviderFactory
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
  
  func requestUserPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
      if granted {
        print("알림 등록이 완료되었습니다.")
      }
    }
    Task {
      _ = await locationUsecasable.requestUserAuthorization()
    }
  }
}
