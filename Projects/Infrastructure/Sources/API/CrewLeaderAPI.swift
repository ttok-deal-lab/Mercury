//
//  CrewLeaderAPI.swift
//  Infrastructure
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

import AppFoundation
import Domain
import Networking

/// sherbet-auth `임장크루장 관리`
enum CrewLeaderAPI {
  /// GET /v1/users/{userId}/crew-leaders (getMyCrewLeaderInfo)
  case myCrewLeaderInfo(userID: Int)
}

extension CrewLeaderAPI: BaseAPI {
  var baseURL: String {
    RestAPIDefine.base(.auth)
  }
  
  var domain: String? {
    "v1/users/"
  }
  
  var path: String {
    switch self {
    case let .myCrewLeaderInfo(userID):
      "\(userID)/crew-leaders"
    }
  }
  
  var method: Networking.HTTPMethod {
    switch self {
    case .myCrewLeaderInfo:
      return .get
    }
  }
  
  var headers: [String: String]? {
    switch self {
    case .myCrewLeaderInfo:
      return ["Authorization": MercuryContainer.shared.resolve(SignInInformationReadable.self).accessToken?.value ?? ""]
    }
  }
}
