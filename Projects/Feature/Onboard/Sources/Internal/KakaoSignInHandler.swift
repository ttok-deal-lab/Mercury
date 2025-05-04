//
//  KakaoSignInHandler.swift
//  Onboard
//
//  Created by 최수훈 on 5/4/25.
//
import Foundation

import KakaoSDKCommon
import KakaoSDKAuth

class KakaoSignInHandler: SocialSignInURLHandler {
  @MainActor func handle(url: URL) -> Bool {
    return AuthController.handleOpenUrl(url: url)
  }
  
}
