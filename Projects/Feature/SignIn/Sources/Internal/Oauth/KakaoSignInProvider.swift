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
  
  // MARK: - private property
  private var continuation: CheckedContinuation<OauthSignInToken, Error>?
  
  // MARK: - internal method
  public func logout() {
    // doSomeThing()
  }
  
  func signIn() async throws -> OauthSignInToken {
    
    return try await withCheckedThrowingContinuation { [weak self] continuation in
      self?.continuation = continuation
      if (UserApi.isKakaoTalkLoginAvailable()) { // 카카오톡으로 로그인
        UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
          self?.handleLoginResult(oauthToken: oauthToken, error: error)
        }
      } else { // WebView 띄워서 카카오 계정으로 로그인
        UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
          self?.handleLoginResult(oauthToken: oauthToken, error: error)
        }
        
      }
    }
  }
  
  private func handleLoginResult(oauthToken: OAuthToken?, error: Error?) {
    if let error = error {
      self.continuation?.resume(throwing: error)
      self.continuation = nil
      return
    }
    
    if let token = oauthToken?.accessToken {
      self.continuation?.resume(returning: token)
    } else {
      self.continuation?.resume(throwing: MercuryError(from: .ownModule(.kakaoSignin), .unknown))
    }
    self.continuation = nil
  }
  
}
