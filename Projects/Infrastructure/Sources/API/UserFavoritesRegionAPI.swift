//
//  UserFavoritesRegion.swift
//  Infrastructure
//
//  Created by 송하민 on 3/30/25.
//

import Foundation

import Networking

enum UserFavoritesRegionAPI {
  case loadFavoritesRegion(userID: String, regionID: Int)
  case addFavoritesRegion(userID: String, regionID: Int)
  case deleteFavoritesRegion(userID: String, regionID: Int)
  case editFavoritesRegion(userID: String, regionID: Int)
  case loadAllFavoritesRegions(userID: String)
}

extension UserFavoritesRegionAPI: BaseAPI {
  var baseURL: String {
    RestAPIDefine.base(.auth)
  }
  
  var domain: String? {
    "v1/users/"
  }
  
  var path: String {
    switch self {
    case let .loadFavoritesRegion(userID, regionID):
      return "\(userID)/favorites/regions/\(regionID)"
    case let .addFavoritesRegion(userID, regionID):
      return "\(userID)/favorites/regions/\(regionID)"
    case let .deleteFavoritesRegion(userID, regionID):
      return "\(userID)/favorites/regions/\(regionID)"
    case let .editFavoritesRegion(userID, regionID):
      return "\(userID)/favorites/regions/\(regionID)"
    case let .loadAllFavoritesRegions(userID):
      return "\(userID)/favorites/regions"
    }
  }
  
  var method: Networking.HTTPMethod {
    switch self {
    case .loadFavoritesRegion:
      return .get
    case .addFavoritesRegion:
      return .post
    case .deleteFavoritesRegion:
      return .delete
    case .editFavoritesRegion:
      return .patch
    case .loadAllFavoritesRegions:
      return .get
    }
  }
}

