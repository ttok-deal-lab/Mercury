//
//  GoogleSignInHandler.swift
//  Onboard
//
//  Created by 최수훈 on 5/4/25.
//
import GoogleSignIn
import GoogleSignInSwift

public class GoogleSignInHandler: DeeplinkHandlable {
  public init() { }
  
  public func handle(url: URL) -> Bool {
    return GIDSignIn.sharedInstance.handle(url)
  }
}
