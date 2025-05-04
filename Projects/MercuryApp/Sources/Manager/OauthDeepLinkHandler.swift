//
//  OauthDeepLinkHandler.swift
//  Onboard
//
//  Created by 최수훈 on 5/4/25.
//
import Foundation

import Onboard

public class OauthDeepLinkHandler {
  public static let shared = OauthDeepLinkHandler(handlers: [
    GoogleSignInHandler(),
    NidOAuthHandler(),
    KakaoSignInHandler()
  ])
  
  private let handlers: [DeeplinkHandlable]
  
  private init(handlers: [DeeplinkHandlable]) {
    self.handlers = handlers
  }
  
  public func handle(url: URL) {
    for handler in handlers {
      if handler.handle(url: url) {
        return
      }
    }
    print("Handler not found : \(url)")
  }
}
