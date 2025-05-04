//
//  NidOAuthHandler.swift
//  Onboard
//
//  Created by 최수훈 on 5/4/25.
//
import Foundation

import NidThirdPartyLogin
import NidLogin

class NidOAuthHandler: SocialSignInURLHandler {
  func handle(url: URL) -> Bool {
    return NidOAuth.shared.handleURL(url)
  }
}
