//
//  UserFavoritesRegionPriceAPI.swift
//  Infrastructure
//
//  Created by 송하민 on 3/30/25.
//

import Foundation

import Networking

enum UserFavoritesRegionPriceAPI {
  case loadFavoritesRegionPrice(userID: String, regionID: Int)
  case addFavoritesRegionPrice(userID: String, regionID: Int)
  case deleteFavoritesRegionPrice(userID: String, regionID: Int)
  case editFavoritesRegionPrice(userID: String, regionID: Int)
  case loadAllFavoritesRegionPrices(userID: String)
}

extension UserFavoritesRegionPriceAPI: BaseAPI {
  var baseURL: String {
    RestAPIDefine.base(.auth)
  }
  
  var domain: String? {
    "v1/users/"
  }
  
  var path: String {
    switch self {
    case let .loadFavoritesRegionPrice(userID, regionID):
      return "\(userID)/favorites/regions/\(regionID)/price"
    case let .addFavoritesRegionPrice(userID, regionID):
      return "\(userID)/favorites/regions/\(regionID)/price"
    case let .deleteFavoritesRegionPrice(userID, regionID):
      return "\(userID)/favorites/regions/\(regionID)/price"
    case let .editFavoritesRegionPrice(userID, regionID):
      return "\(userID)/favorites/regions/\(regionID)/price"
    case let .loadAllFavoritesRegionPrices(userID):
      return "\(userID)/favorites/regions/price"
    }
  }
  
  var method: Networking.HTTPMethod {
    switch self {
    case .loadFavoritesRegionPrice:
      return .get
    case .addFavoritesRegionPrice:
      return .post
    case .deleteFavoritesRegionPrice:
      return .delete
    case .editFavoritesRegionPrice:
      return .patch
    case .loadAllFavoritesRegionPrices:
      return .get
    }
  }
}
