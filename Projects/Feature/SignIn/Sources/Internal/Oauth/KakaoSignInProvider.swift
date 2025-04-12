//
//  KakaoSignInProvider.swift
//  Domain
//
//  Created by 최수훈 on 3/30/25.
//


import Foundation

import AppFoundation

import KakaoSDKCommon
import KakaoSDKUser
import KakaoSDKAuth

class KakaoSignInProvider: NSObject, SignInable {
  
  // MARK: - internal method
  
  @MainActor
  func signIn() async throws -> OauthSignInToken {
    
    return try await withCheckedThrowingContinuation { continuation in
      if (UserApi.isKakaoTalkLoginAvailable()) { // 카카오톡으로 로그인
        UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
          if let error = error {
            let mercuryError = MercuryError(code: (error as NSError).code)
            continuation.resume(throwing: mercuryError)
            return
          }
          guard let token = oauthToken?.idToken else {
            continuation.resume(throwing: MercuryError(from: .ownModule(.kakaoSignin), .unknown))
            return
          }
          continuation.resume(returning: token)
        }
      } else { // WebView 띄워서 카카오 계정으로 로그인
        UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
          if let error = error {
            let mercuryError = MercuryError(code: (error as NSError).code)
            continuation.resume(throwing: mercuryError)
            return
          }
          guard let token = oauthToken?.idToken else {
            continuation.resume(throwing: MercuryError(from: .ownModule(.kakaoSignin), .unknown))
            return
          }
          continuation.resume(returning: token)
        }
      }
    }
  }
}
