//
//  NidOAuthHandler.swift
//  Onboard
//
//  Created by 최수훈 on 5/4/25.
//

import Foundation

import Domain

import NidThirdPartyLogin
import NidLogin

public class NidOAuthHandler: DeeplinkHandlable {
  public init() { }
  public func handle(url: URL) -> Bool {
    return NidOAuth.shared.handleURL(url)
  }
}
