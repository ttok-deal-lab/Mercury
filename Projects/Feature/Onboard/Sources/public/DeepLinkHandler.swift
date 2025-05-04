//
//  DeepLInkHandler.swift
//  Onboard
//
//  Created by 최수훈 on 5/4/25.
//
import Foundation

public class DeepLinkHandler {
  public static let shared = DeepLinkHandler(handlers: [
    GoogleSignInHandler(),
    NidOAuthHandler(),
    KakaoSignInHandler()
  ])
  
  private let handlers: [SocialSignInURLHandler]
  
  private init(handlers: [SocialSignInURLHandler]) {
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
