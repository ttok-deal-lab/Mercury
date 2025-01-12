//
//  AuthAPI.swift
//  Infrastructure
//
//  Created by 송하민 on 1/12/25.
//

import Foundation

import Network

public enum AuthAPI {
  case signIn(provider: String, idToken: String)
}

extension AuthAPI: BaseAPI {
  public var baseURL: String {
    RestAPIDefine.baseURL
  }
  
  public var domain: String? {
    return "auth/"
  }
  
  public var path: String {
    switch self {
    case let .signIn(providier, _):
      "\(providier)"
    }
  }
  
  public var method: Network.HTTPMethod {
    switch self {
    case .signIn:
      return .post
    }
  }
  
  public var requestBody: [String : Any]? {
    switch self {
    case let .signIn(_, idToken):
      return [
        "idToken": idToken
      ]
    }
  }
    
}
