//
//  AppleSignInManager.swift
//  Domain
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import AppFoundation
import AuthenticationServices

final class AppleSignInProvider: SignInable {
  
  // MARK: - private property
  
  private var delegate: AppleSignInDelegate?
  
  // MARK: - internal method
  
  func signIn() async throws -> OauthSignInToken {
    try await withCheckedThrowingContinuation { continuation in
      let provider = ASAuthorizationAppleIDProvider()
      let request = provider.createRequest()
      request.requestedScopes = [.fullName, .email]
      
      let controller = ASAuthorizationController(authorizationRequests: [request])
      self.delegate = AppleSignInDelegate(continuation: continuation)
      controller.delegate = self.delegate
      controller.performRequests()
    }
  }
}

private class AppleSignInDelegate: NSObject, ASAuthorizationControllerDelegate {
  
  // MARK: - private property
  
  private let continuation: CheckedContinuation<OauthSignInToken, Error>
  
  // MARK: - life cycle
  
  init(continuation: CheckedContinuation<OauthSignInToken, Error>) {
    self.continuation = continuation
  }
  
  // MARK: - internal method
  
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
       let identityToken = appleIDCredential.identityToken,
       let tokenString = String(data: identityToken, encoding: .utf8) {
      continuation.resume(returning: tokenString)
    } else {
      continuation.resume(throwing: MercuryError(from: .ownModule(.appleSignin), .unknown))
    }
  }
  
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    continuation.resume(throwing: MercuryError(code: (error as NSError).code))
  }
}
