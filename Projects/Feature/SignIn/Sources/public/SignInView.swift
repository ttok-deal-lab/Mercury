//
//  AppleSignInButton.swift
//  Onboarding
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import SwiftUI

import AppFoundation
import Domain

public struct SignInView: View {
  @StateObject private var signInModelData: SignInModelData
  @State private var error: MercuryError?
  private let supportSignInTypes: [OauthProvider] = [.apple, .google, .naver, .kakao]
  
  public init(
    serviceSignInUsecasable: ServiceSignInUsecasable,
    localStorageUsecasable: LocalStorageUsecasable
  ) {
    self._signInModelData = StateObject(
      wrappedValue: SignInModelData(
        serviceSignInUsecasable: serviceSignInUsecasable,
        localStorageUsecasable: localStorageUsecasable
      )
    )
  }
  
  public var body: some View {
    ZStack {
      VStack(spacing: 8) {
        ForEach(supportSignInTypes) { type in
          signInButton(type: type)
            .padding(.horizontal, 20)
        }
      }
    }
  }
  
  @ViewBuilder
  private func signInButton(type: OauthProvider) -> some View {
    switch type {
    case .apple:
      AppleSignInButton {
        do {
          try signInModelData.oauthSignIn(.apple)
        } catch let error as MercuryError {
          self.error = error
        }
      }
    case .google:
      GoogleSignInButtonView {
        do {
          try signInModelData.oauthSignIn(.google)
        } catch let error as MercuryError {
          self.error = error
        }
      }
    case .naver:
      NaverSignInButtonView {
        do {
          try signInModelData.oauthSignIn(.naver)
        } catch let error as MercuryError {
          self.error = error
        }
      }

    case .kakao:
      KakaoSignInButtonView {
        do {
          try signInModelData.oauthSignIn(.kakao)
        } catch let error as MercuryError {
          self.error = error
        }
      }
    }
  }
}
