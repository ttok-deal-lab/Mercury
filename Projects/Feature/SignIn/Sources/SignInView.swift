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
  
  // MARK: - private property
  
  @StateObject private var signInModelData: SignInModelData
  @State private var error: MercuryError?
  private let supportSignInTypes: [OauthProvider] = [.apple, .google]
  
  // MARK: - life cycle
  
  public init(signInUsecase: SignInUsecase) {
    self._signInModelData = StateObject(wrappedValue: SignInModelData(signInUsecase: signInUsecase))
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
    }
  }
}
