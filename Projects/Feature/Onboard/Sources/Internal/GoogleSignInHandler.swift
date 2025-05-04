//
//  GoogleSignInHandler.swift
//  Onboard
//
//  Created by 최수훈 on 5/4/25.
//
import GoogleSignIn
import GoogleSignInSwift

class GoogleSignInHandler: SocialSignInURLHandler {
  func handle(url: URL) -> Bool {
    return GIDSignIn.sharedInstance.handle(url)
  }
}
