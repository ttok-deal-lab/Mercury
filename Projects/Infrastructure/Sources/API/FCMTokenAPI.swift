//
//  fcmAPI.swift
//  Infrastructure
//
//  Created by 송하민 on 3/30/25.
//

import Foundation

import Network

public enum FCMTokenAPI {
  case registFCMToken(userID: String, deviceID: String)
  case loadFCMToken(userID: String)
  case requestDeleteFCMToken(userID: String)
}

extension FCMTokenAPI: BaseAPI {
  
  public var baseURL: String {
    RestAPIDefine.base(.common)
  }
  
  public var domain: String? {
    "v1/fcm/"
  }
  
  public var path: String {
    switch self {
    case let .registFCMToken(userID, deviceID):
      return "\(userID)/\(deviceID)"
    case let .loadFCMToken(userID):
      return "\(userID)"
    case let .requestDeleteFCMToken(userID):
      return "\(userID)"
    }
  }
  
  public var method: Network.HTTPMethod {
    switch self {
    case .registFCMToken:
      return .post
    case .loadFCMToken:
      return .get
    case .requestDeleteFCMToken:
      return .delete
    }
  }
  
  
}
