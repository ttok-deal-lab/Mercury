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
  case registFCMToken(fcmToken: String, userID: Int, deviceID: String, deviceType: String)
  case loadFCMToken(userID: Int)
  case requestDeleteFCMToken(userID: Int)
}

extension FCMTokenAPI: BaseAPI {
  
  var baseURL: String {
    RestAPIDefine.base(.auth)
  }
  
  var domain: String? {
    "v1/users/"
  }
  
  var path: String {
    switch self {
    case let .registFCMToken(_, userID, deviceID, _):
      return "\(userID)/fcm/\(deviceID)"
    case let .loadFCMToken(userID):
      return "\(userID)/fcm"
    case let .requestDeleteFCMToken(userID):
      return "\(userID)/fcm"
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
  
  var headers: [String: String]? {
    let accessToken: String  = MercuryContainer.shared.resolve(SignInInformationReadable.self).accessToken?.value ?? ""
    return ["Authorization": accessToken]
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
