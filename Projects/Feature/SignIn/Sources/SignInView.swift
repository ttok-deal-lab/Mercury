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
  private let supportSignInTypes: [OauthProvider] = [.apple, .google, .naver]
  
  public init(
    signInUsecasable: SignInUsecasable,
    localStorageUsecasable: LocalStorageUsecasable
  ) {
    self._signInModelData = StateObject(
      wrappedValue: SignInModelData(
        signInUsecasable: signInUsecasable,
        localStorageUsecasable: localStorageUsecasable
      )
    )
  }
  
  public var body: some View {
    ZStack {
   
      VStack(spacing: 8) {
        ForEach(supportSignInTypes) { type in
          signInButton(type: type)
        }
      }
    }
  }
  
  @ViewBuilder
  private func signInButton(type: OauthProvider) -> some View {
    switch type {
    case .apple:
      AppleSignInButton(signInModelData: signInModelData, error: $error)
    case .google:
      GoogleSignInButtonView(signInModelData: signInModelData, error: $error)
    case .naver:
      NaverSignInButtonView(signInModelData: signInModelData, error: $error)
    }
  }
}
