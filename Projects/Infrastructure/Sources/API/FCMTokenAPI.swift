//
//  fcmAPI.swift
//  Infrastructure
//
//  Created by 송하민 on 3/30/25.
//

import Foundation

import AppFoundation
import Domain
import Networking

enum FCMTokenAPI {
  case registFCMToken(fcmToken: String, userID: String, deviceID: String, deviceType: String)
  case loadFCMToken(userID: String)
  case requestDeleteFCMToken(userID: String)
}

extension FCMTokenAPI: BaseAPI {
  
  var baseURL: String {
    RestAPIDefine.base(.common)
  }
  
  var domain: String? {
    "v1/fcm/"
  }
  
  var path: String {
    switch self {
    case let .registFCMToken(_, userID, deviceID, _):
      return "\(userID)/\(deviceID)"
    case let .loadFCMToken(userID):
      return "\(userID)"
    case let .requestDeleteFCMToken(userID):
      return "\(userID)"
    }
  }
  
  var requestBody: [String : Any]? {
    nil
  }
  
  var method: Networking.HTTPMethod {
    switch self {
    case .registFCMToken:
      return .post
    case .loadFCMToken:
      return .get
    case .requestDeleteFCMToken:
      return .delete
    }
  }
  
  var additionalHeaders: [String : String]? {
    switch self {
    case let .registFCMToken(fcmToken, _, _, deviceType):
      return [
        "FCM-TOKEN": fcmToken,
        "DEVICE-TYPE": deviceType
      ]
    default:
      return nil
    }
  }
  
  
}
