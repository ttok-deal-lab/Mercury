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
  case isAuctionInterested(userID: Int, auctionID: Int, type: String? = "product")
  case addInterest(userID: Int, auctionID: Int, type: String? = "product")
  case removeInterest(userID: Int, auctionID: Int, type: String? = "product")
  case fetchInterest(userID: Int, type: String? = "product", nextCursor: String?)
  case fetchInterestList(userID: Int, ids: [Int])
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
    case let .isAuctionInterested(userID, auctionID, _),
      let .addInterest(userID, auctionID, _),
      let .removeInterest(userID, auctionID, _):
      return "\(userID)/favorites/\(auctionID)"
    case let .fetchInterest(userID, _, _):
      return "\(userID)/favorites"
    case let .fetchInterestList(userID, ids):
      let idsString = ids
        .map { "ids=\($0)" }
        .joined(separator: "&")
      return "\(userID)/favorites/ids?\(idsString)"
    }
  }
  
  var method: Networking.HTTPMethod {
    switch self {
    case .isAuctionInterested:
      return .get
    case .addInterest:
      return .post
    case .removeInterest:
      return .delete
    case .fetchInterest:
      return .get
    case .fetchInterestList:
      return .get
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .isAuctionInterested(_, _, _),
        .addInterest(_, _, _),
        .removeInterest(_, _, _),
        .fetchInterest(_, _, _),
        .fetchInterestList(_, _):
      Log.debug(MercuryContainer.shared.resolve(SignInInformationReadable.self).accessToken?.value ?? "")
      return ["Authorization" : MercuryContainer.shared.resolve(SignInInformationReadable.self).accessToken?.value ?? ""]
    }
  }
  
  var queryParam: [String: Any]? {
    switch self {
    case let .addInterest(_, _, type),
      let .removeInterest(_, _, type),
      let .isAuctionInterested(_, _, type):
      var params: [String: Any] = [:]
      
      if let type = type {
        params["type"] = type.description
      } else {
        params["type"] = "product"
      }
      
      return params
    case let .fetchInterest(_, type, nextCursor):
      var params: [String: Any] = [:]
      
      if let type = type {
        params["type"] = type.description
      } else {
        params["type"] = "product"
      }
      
      if let nextCursor = nextCursor {
        params["nextCursor"] = nextCursor
      }
      
      return params
    case .fetchInterestList(_, _):
      return nil
    }
  }
}

