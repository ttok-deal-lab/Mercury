//
//  KakaoSignInHandler.swift
//  Onboard
//
//  Created by 최수훈 on 5/4/25.
//
import Foundation

import Domain

import KakaoSDKCommon
import KakaoSDKAuth

public class KakaoSignInHandler: @preconcurrency DeeplinkHandlable {
  public init() { }
  
  @MainActor
  public func handle(url: URL) -> Bool {
    return AuthController.handleOpenUrl(url: url)
  }
  
}
