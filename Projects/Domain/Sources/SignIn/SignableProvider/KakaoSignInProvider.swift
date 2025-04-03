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
        if (UserApi.isKakaoTalkLoginAvailable()) {
          UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            debugPrint("Kakao Oauth Token: ", oauthToken)
            debugPrint("Kakao Oauth Error: ",error)
          }
        } else {
          UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            debugPrint("Kakao Oauth Token: ",oauthToken)
            debugPrint("Kakao Oauth Error: ",error)
          }
        self?.continuation = continuation
      }
    }
  }
  
  private func kakaoToken() {
    // do SomeThing
  }
}
