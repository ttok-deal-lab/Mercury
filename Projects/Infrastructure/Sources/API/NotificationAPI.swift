//
//  NotificationAPI.swift
//  Infrastructure
//
//  Created by 송하민 on 3/30/25.
//

import Foundation

import AppFoundation
import Domain
import Networking

enum NotificationAPI {
  case loadNotifications(sessionID: String)
  case loadUnreadNotifications(sessionID: String)
  case loadCountUnreadNotifications(sessionID: String)
}

extension NotificationAPI: BaseAPI {
  var baseURL: String {
    RestAPIDefine.base(.common)
  }
  
  var domain: String? {
    "v1/notification/"
  }
  
  var path: String {
    switch self {
    case let .loadNotifications(sessionID):
      return "\(sessionID)"
    case let .loadUnreadNotifications(sessionID):
      return "\(sessionID)/unconfirmed"
    case let .loadCountUnreadNotifications(sessionID):
      return "\(sessionID)/unconfirmed/count"
    }
  }
  
  var method: Networking.HTTPMethod {
    switch self {
    case .loadNotifications:
      return .get
    case .loadUnreadNotifications:
      return .get
    case .loadCountUnreadNotifications:
      return .get
    }
  }

  var headers: [String: String]? {
    ["Authorization": MercuryContainer.shared.resolve(SignInInformationReadable.self).accessToken?.value ?? ""]
  }

}
