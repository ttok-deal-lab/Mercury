//
//  AuthAPI.swift
//  Infrastructure
//
//  Created by 송하민 on 1/12/25.
//

import Foundation

import Networking

enum AuthAPI {
  case signIn(provider: String, idToken: String)
}

extension AuthAPI: BaseAPI {
  var baseURL: String {
    RestAPIDefine.base(.auth)
  }
  
  var domain: String? {
    return "v1/auth/"
  }
  
  var path: String {
    switch self {
    case let .signIn(providier, _):
      "\(providier)"
    }
  }
  
  var method: Networking.HTTPMethod {
    switch self {
    case .signIn:
      return .post
    }
  }
  
  var requestBody: [String : Any]? {
    switch self {
    case let .signIn(_, idToken):
      return [
        "idToken": idToken
      ]
    }
  }
    
}
