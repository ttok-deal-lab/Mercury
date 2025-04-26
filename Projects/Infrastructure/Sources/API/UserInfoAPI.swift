//
//  UserInfoAPI.swift
//  Infrastructure
//
//  Created by 송하민 on 3/30/25.
//

import Foundation

import Network

enum UserInfoAPI {
  case userInfo(userID: Int)
}

extension UserInfoAPI: BaseAPI {
  var baseURL: String {
    RestAPIDefine.base(.auth)
  }
  
  var domain: String?  {
    return "v1/users/"
  }
  
  var path: String {
    switch self {
    case let .userInfo(userID):
      "\(userID)"
    }
  }
  
  var method: Network.HTTPMethod {
    switch self {
    case .userInfo:
      return .get
    }
  }
  
  
}
