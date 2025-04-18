//
//  UserInfoAPI.swift
//  Infrastructure
//
//  Created by 송하민 on 3/30/25.
//

import Foundation

import Network

public enum UserInfoAPI {
  case userInfo(userID: Int)
}

extension UserInfoAPI: BaseAPI {
  public var baseURL: String {
    RestAPIDefine.base(.auth)
  }
  
  public var domain: String?  {
    return "v1/users/"
  }
  
  public var path: String {
    switch self {
    case let .userInfo(userID):
      "\(userID)"
    }
  }
  
  public var method: Network.HTTPMethod {
    switch self {
    case .userInfo:
      return .get
    }
  }
  
  
}
