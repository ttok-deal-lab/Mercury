//
//  AppleSignInButton.swift
//  Onboarding
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import SwiftUI
import AuthenticationServices

public struct AppleSignInButton: View {
  public init() { }
  
  public var body: some View {
    ZStack {
      SignInWithAppleButton(.signUp) { request in
        request.requestedScopes = [.fullName, .email]
      } onCompletion: { result in
        print(result)
        switch result {
        case .success(let authorization):
          handleSuccessfulLogin(with: authorization)
        case .failure(let error):
          handleLoginError(with: error)
        }
      }
      .frame(height: 50)
      .padding()
      
    }
  }
  
  // TODO: 리듀서로 옮길것
  private func handleSuccessfulLogin(with authorization: ASAuthorization) {
    if let userCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
      print("user: \(userCredential.user)")
      print("jwt: \(String(describing: String(data: userCredential.identityToken ?? Data(), encoding: .utf8)))")
      
      
      if userCredential.authorizedScopes.contains(.fullName) {
        print(userCredential.fullName?.givenName ?? "No given name")
      }
      
      if userCredential.authorizedScopes.contains(.email) {
        print(userCredential.email ?? "No email")
      }
    }
  }
  
  // TODO: 리듀서로 옮길것
  private func handleLoginError(with error: Error) {
    print("Could not authenticate: \\(error.localizedDescription)")
  }
}
