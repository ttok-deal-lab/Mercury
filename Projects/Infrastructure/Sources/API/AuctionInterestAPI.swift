//
//  AuctionFavoritesAPI.swift
//  Infrastructure
//
//  Created by 최수훈 on 1/20/26.
//

import Foundation

import AppFoundation
import Domain
import Networking

enum AuctionInterestAPI {
  case isAuctionUserInterested(userID: Int, auctionID: Int, type: String? = "product")
  case addUserInterestAuction(userID: Int, auctionID: Int, type: String? = "product")
  case removeUserInterestAuction(userID: Int, auctionID: Int, type: String? = "product")
  case fetchUserInterestAuctions(userID: Int, type: String? = "product", nextCursor: String?, size: Int? = 20)
}

extension AuctionInterestAPI: BaseAPI {
  
  var baseURL: String {
    RestAPIDefine.base(.auth)
  }
  
  var domain: String? {
    "v1/users/"
  }
  
  var path: String {
    switch self {
    case let .isAuctionUserInterested(userID, auctionID, _),
      let .addUserInterestAuction(userID, auctionID, _),
      let .removeUserInterestAuction(userID, auctionID, _):
      return "\(userID)/favorites/\(auctionID)"
    case let .fetchUserInterestAuctions(userID, _, _, _):
      return "\(userID)/favorites"
    }
  }
  
  var method: Networking.HTTPMethod {
    switch self {
    case .isAuctionUserInterested:
      return .get
    case .addUserInterestAuction:
      return .post
    case .removeUserInterestAuction:
      return .delete
    case .fetchUserInterestAuctions:
      return .get
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .isAuctionUserInterested(_, _, _),
        .addUserInterestAuction(_, _, _),
        .removeUserInterestAuction(_, _, _),
        .fetchUserInterestAuctions(_, _, _, _):
      return ["Authorization" : MercuryContainer.shared.resolve(SignInInformationReadable.self).accessToken?.value ?? ""]
    }
  }
  
  var queryParam: [String: Any]? {
    switch self {
    case let .addUserInterestAuction(_, _, type),
      let .removeUserInterestAuction(_, _, type),
      let .isAuctionUserInterested(_, _, type):
      var params: [String: Any] = [:]
      
      if let type = type {
        params["type"] = type.description
      } else {
        params["type"] = "product"
      }
      
      return params
    case let .fetchUserInterestAuctions(_, type, nextCursor, size):
      var params: [String: Any] = [:]
      
      if let type = type {
        params["type"] = type.description
      } else {
        params["type"] = "product"
      }
      
      if let nextCursor = nextCursor {
        params["cursor"] = nextCursor
      }
      
      if let size = size {
        params["size"] = size
      } else {
        params["size"] = 20
      }
      
      return params
    }
  }
}

