//
//  OauthDeepLinkHandler.swift
//  Onboard
//
//  Created by 최수훈 on 5/4/25.
//

import Foundation
import AppFoundation

import Onboard
import Domain

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
    Log.debug("Handler not found : \(url)")
  }
}
