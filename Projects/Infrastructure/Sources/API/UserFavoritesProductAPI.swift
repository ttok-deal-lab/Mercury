//
//  UserFavoritesAPI.swift
//  Infrastructure
//
//  Created by 송하민 on 3/30/25.
//

import Foundation

import Network

public enum UserFavoritesProductAPI {
  case loadFavoritesProduct(userID: String, productID: Int)
  case addFavoritesProduct(userID: String, productID: Int)
  case deleteFavoritesProduct(userID: String, productID: Int)
  case editFavoritesProduct(userID: String, productID: Int)
  case loadAllFavoritesProducts(userID: String)
}

extension UserFavoritesProductAPI: BaseAPI {
  public var baseURL: String {
    RestAPIDefine.base(.auth)
  }
  
  public var domain: String? {
    "v1/users/"
  }
  
  public var path: String {
    switch self {
    case let .loadFavoritesProduct(userID, productID):
      return "\(userID)/favorites/products/\(productID)"
    case let .addFavoritesProduct(userID, productID):
      return "\(userID)/favorites/products/\(productID)"
    case let .deleteFavoritesProduct(userID, productID):
      return "\(userID)/favorites/products/\(productID)"
    case let .editFavoritesProduct(userID, productID):
      return "\(userID)/favorites/products/\(productID)"
    case let .loadAllFavoritesProducts(userID):
      return "\(userID)/favorites/products"
    }
  }
  
  public var method: Network.HTTPMethod {
    switch self {
    case .loadFavoritesProduct:
      return .get
    case .addFavoritesProduct:
      return .post
    case .deleteFavoritesProduct:
      return .delete
    case .editFavoritesProduct:
      return .patch
    case .loadAllFavoritesProducts:
      return .get
    }
  }
}
