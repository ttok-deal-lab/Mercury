//
//  NotificationAPI.swift
//  Infrastructure
//
//  Created by 송하민 on 3/30/25.
//

import Foundation

import Network

public enum NotificationAPI {
  case loadNotifications(sessionID: String)
  case loadUnreadNotifications(sessionID: String)
  case loadCountUnreadNotifications(sessionID: String)
}

extension NotificationAPI: BaseAPI {
  public var baseURL: String {
    RestAPIDefine.base(.common)
  }
  
  public var domain: String? {
    "v1/notification/"
  }
  
  public var path: String {
    switch self {
    case let .loadNotifications(sessionID):
      return "\(sessionID)"
    case let .loadUnreadNotifications(sessionID):
      return "\(sessionID)/unconfirmed"
    case let .loadCountUnreadNotifications(sessionID):
      return "\(sessionID)/unconfirmed/count"
    }
  }
  
  public var method: Network.HTTPMethod {
    switch self {
    case .loadNotifications:
      return .get
    case .loadUnreadNotifications:
      return .get
    case .loadCountUnreadNotifications:
      return .get
    }
  }
  
  
}
