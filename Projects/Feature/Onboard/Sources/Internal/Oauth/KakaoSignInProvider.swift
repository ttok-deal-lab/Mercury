//
//  KakaoSignInProvider.swift
//  Domain
//
//  Created by 최수훈 on 3/30/25.
//


import Foundation

import AppFoundation
import Domain

import KakaoSDKCommon
import KakaoSDKUser
import KakaoSDKAuth

class KakaoSignInProvider: OauthSignInable {
  
  private let userCancelCode: Int = .zero
  
  private func kakaoTalkLogin(continuation: CheckedContinuation<OauthSignInToken, any Error>) {
    UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
      if let error = error {
        let mercuryError = MercuryError(code: (error as NSError).code)
        continuation.resume(throwing: mercuryError)
        return
      }
      guard let token = oauthToken?.idToken else {
        continuation.resume(throwing: MercuryError(.noOauthToken))
        return
      }
      continuation.resume(returning: token)
    }
  }
  
  private func kakaoAccountLogin(continuation: CheckedContinuation<OauthSignInToken, any Error>) {
    UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
      if let error = error {
        guard (error as NSError).code != self?.userCancelCode else { return }
        continuation.resume(throwing: MercuryError(code: (error as NSError).code))
        return
      }
      guard let token = oauthToken?.accessToken else {
        continuation.resume(throwing: MercuryError(.noOauthToken))
        return
      }
      
      continuation.resume(returning: token)
    }
  }
  
  // MARK: - internal method
  
  @MainActor
  func signIn() async throws -> OauthSignInToken {
    return try await withCheckedThrowingContinuation { continuation in
      UserApi.isKakaoTalkLoginAvailable() ? kakaoTalkLogin(continuation: continuation) : kakaoAccountLogin(continuation: continuation)
    }
  }
}
