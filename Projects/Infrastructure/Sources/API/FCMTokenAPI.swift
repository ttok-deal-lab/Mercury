//
//  fcmAPI.swift
//  Infrastructure
//
//  Created by 송하민 on 3/30/25.
//

import Foundation

import AppFoundation
import Domain
import Network

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
    switch self {
    case let .registFCMToken(fcmToken, userID, deviceID, deviceType):
      let param: [String: Any] = [
        "userId": userID,
        "deviceId": deviceID,
        "FCM-TOKEN": fcmToken,
        "DEVICE-TYPE": deviceType
      ]
      return param
    default:
      return nil
    }
  }
  
  var method: Network.HTTPMethod {
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
    case .registFCMToken:
      if let accessToken = MercuryContainer.shared.resolve(SignInInformationReadable.self).accessToken {
        return ["Authorization" : accessToken.value]
      }
      return nil
    default:
      return nil
    }
  }
  
  
}
