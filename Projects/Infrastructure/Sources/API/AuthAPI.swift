//
//  AuthAPI.swift
//  Infrastructure
//
//  Created by 송하민 on 1/12/25.
//

import Foundation

import AppFoundation
import Domain
import Networking

enum AuthAPI {
  case signIn(provider: String, idToken: String)
  case signOut(userID: Int)
  case logout(deviceID: String)
}

extension AuthAPI: BaseAPI {
  var baseURL: String {
    RestAPIDefine.base(.auth)
  }
  
  var domain: String? {
    switch self {
    case .signIn, .logout:
      return "v1/auth/"
    case .signOut:
      return "v1/users/"
    }
  }
  
  var path: String {
    switch self {
    case let .signIn(providier, _):
      "\(providier)"
    case let .signOut(userID):
      "\(userID)"
    case .logout:
      "logout"
    }
    
  }
  
  var method: Networking.HTTPMethod {
    switch self {
    case .signIn:
      return .post
    case .logout:
      return .post
    case .signOut:
      return .delete
    }
  }
  
  var requestBody: [String : Any]? {
    switch self {
    case let .signIn(_, idToken):
      return [
        "idToken": idToken
      ]
    default: return nil
    }
  }
  
  var additionalHeaders: [String: String]? {
    switch self {
    case .signOut:
      return ["Authorization": MercuryContainer.shared.resolve(SignInInformationReadable.self).accessToken?.value ?? ""]
    case let .logout(deviceID):
      return [
        "Authorization": MercuryContainer.shared.resolve(SignInInformationReadable.self).accessToken?.value ?? "",
        "DEVICE-ID": deviceID
      ]
    default:
      return nil
    }
  }

}
