//
//  AuthorizationRefreshable.swift
//  AppFoundation
//

import Foundation

public protocol AuthorizationRefreshable {
  func refreshAccessToken(rawValue: String)
}
