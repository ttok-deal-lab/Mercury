//
//  AppleSignInButton.swift
//  Onboarding
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import SwiftUI
import Combine

import UIComponent
import AppFoundation
import Domain
import Router

public struct SignInView: View {
  private var signInModelData: SignInModelData
  @State private var error: MercuryError?
  
  let navigationSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
  public init(
    navigationSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>,
    serviceSignInUsecasable: ServiceSignInUsecasable,
    localStorageUsecasable: LocalStorageUsecasable
  ) {
    self.navigationSubject = navigationSubject
    self.signInModelData = SignInModelData(
      serviceSignInUsecasable: serviceSignInUsecasable,
      localStorageUsecasable: localStorageUsecasable
    )
  }
  
  public var body: some View {
    ZStack {
      VStack(spacing: .zero) {
        Spacer()
        Asset.Images.slugWithTitle.image
        Spacer()
        
        VStack(spacing: 8) {
          ForEach(OauthProvider.allCases) { type in
            SignInButtonView(type: type) {
              await handleSignIn(with: type)
            }
            .padding(.horizontal, 20)
          }
        }
        .padding(.bottom, 50)
      }
    }
    .mercuryError(error: $error)
  }
  
  @MainActor
  private func handleSignIn(with provider: OauthProvider) async {
    do {
      try await signInModelData.oauthSignIn(provider)
      navigationSubject.send(.dismissFullScreen)
    } catch let error as MercuryError  {
      self.error = error
    } catch {
      self.error = MercuryError(.unknown)
    }
  }
}
