//
//  NaverSignInProvider.swift
//  Domain
//
//  Created by 최수훈 on 1/28/25.
//

import UIKit
import AppFoundation

import NaverThirdPartyLogin

class NaverSignInProvider: SignInable {
  var instance = NaverThirdPartyLoginConnection()
  @MainActor
  func signIn() async throws -> OauthSignInToken {
    guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
      throw MercuryError(from: .ownModule(.googleSignin), .unknown)
    }
    
    return try await withCheckedThrowingContinuation { continuation in
      instance.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
        if let error = error {
          let mercuryError = MercuryError(code: (error as! NSError).code)
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
