//
//  GoogleSignInProvider.swift
//  Domain
//
//  Created by 송하민 on 9/16/24.
//

import UIKit
import Foundation

import AppFoundation
import Domain

import GoogleSignIn

class GoogleSignInProvider: OauthSignInable {
  
  private let userCancelCode: Int = -5
  
  @MainActor
  func signIn() async throws -> OauthSignInToken {
    guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
      throw MercuryError(.failToLoadTopWindow)
    }
    
    return try await withCheckedThrowingContinuation { [weak self] continuation in
      GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
        if let error = error {
          guard (error as NSError).code != self?.userCancelCode else { return }
          let mercuryError = MercuryError(code: (error as NSError).code)
          continuation.resume(throwing: mercuryError)
          return
        }
        
        guard let token = result?.user.idToken?.tokenString else {
          continuation.resume(throwing: MercuryError(.noOauthToken))
          return
        }
        continuation.resume(returning: token)
      }
    }
  }
  
}
