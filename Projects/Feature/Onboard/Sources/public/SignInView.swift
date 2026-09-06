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
  @State private var modelData: OnboardingModelData
  @State private var error: Error?
  
  private var onComplete: (() -> Void)?
  
  public init(
    onComplete: (() -> Void)? = nil,
    serviceSignInUsecasable: ServiceSignInUsecasable,
    locationUsecasable: LocationUsecasable
  ) {
    self.onComplete = onComplete
    self.modelData = OnboardingModelData(
      serviceSignInUsecasable: serviceSignInUsecasable,
      locationUsecasable: locationUsecasable
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
    .alert(error: $error)
    .loading(modelData.isLoading)
  }
  
  @MainActor
  private func handleSignIn(with provider: OauthProvider) async {
    // 오프라인 안내는 앱 전역에서 쓰는 네트워크 끊김 바텀시트로 통일한다.
    guard NetworkDisconnectPresenter.shared.ensureConnected() else { return }

    do {
      try await modelData.oauthSignIn(provider)
      onComplete?()
    } catch let error as MercuryError {
      self.error = error
    } catch {
      self.error = MercuryError(.unknown)
    }
  }
}
