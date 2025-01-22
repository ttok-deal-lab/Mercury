//
//  GoogleSignInManager.swift
//  Domain
//
//  Created by 송하민 on 9/16/24.
//

import UIKit
import Foundation
import AppFoundation

import GoogleSignIn
import GoogleSignInSwift

class GoogleSignInProvider: SignInable {
  @MainActor
  func signIn() async throws -> OauthSignInToken {
    guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
      throw MercuryError(from: .ownModule(.googleSignin), .unknown)
    }
    
    return try await withCheckedThrowingContinuation { continuation in
      GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
        if let error = error {
          let mercuryError = MercuryError(code: (error as NSError).code)
          continuation.resume(throwing: mercuryError)
          return
        }
        
        guard let token = result?.user.idToken?.tokenString else {
          continuation.resume(throwing: MercuryError(from: .ownModule(.googleSignin), .unknown))
          return
        }
        
        continuation.resume(returning: token)
      }
    }
  }
  
}
