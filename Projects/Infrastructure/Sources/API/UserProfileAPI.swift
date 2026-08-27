//
//  UserInfoAPI.swift
//  Infrastructure
//
//  Created by 송하민 on 3/30/25.
//

import Foundation

import AppFoundation
import Domain
import Networking

enum UserProfileAPI {
  case userProfile(userID: Int)
}

extension UserProfileAPI: BaseAPI {
  var baseURL: String {
    RestAPIDefine.base(.auth)
  }
  
  var domain: String?  {
    return "v1/users/"
  }
  
  var path: String {
    switch self {
    case let .userProfile(userID):
      "\(userID)"
    }
  }
  
  var method: Networking.HTTPMethod {
    switch self {
    case .userProfile:
      return .get
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .userProfile(_):
      return ["Authorization" : MercuryContainer.shared.resolve(SignInInformationReadable.self).accessToken?.value ?? ""]
    }
  }
  
  
}
