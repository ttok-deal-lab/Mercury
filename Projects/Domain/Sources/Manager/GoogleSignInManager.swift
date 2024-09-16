//
//  GoogleSignInManager.swift
//  Domain
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import AppFoundation
import GoogleSignIn
import GoogleSignInSwift
import UIKit

class GoogleSignInManager: SignInable {
  
  @MainActor
  func signIn() async -> Result<SignInToken, MercuryError> {
    guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
      return .failure(.init(from: .ownModule(.googleSignin), .unknown))
    }
    
    return await withCheckedContinuation { continuation in
      GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
        guard let result = result else {
          continuation.resume(returning: .failure(.init(code: (error as? NSError)?.code ?? -1)))
          return
        }
        continuation.resume(returning: .success(result.user.accessToken.tokenString))
      }
    }
  }
  
}
