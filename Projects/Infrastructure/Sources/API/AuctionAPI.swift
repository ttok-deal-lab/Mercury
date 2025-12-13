//
//  AuctionAPI.swift
//  Auction
//
//  Created by 최수훈 on 11/6/24.
//

import Foundation

import Networking

enum AuctionAPI: BaseAPI {
  case auctionSearchList(keyword: String?, region: String?, district: String?, buildType: String?, auctionFailCount: String?, varificationStatus: String?, minimumPrice: Int?, maximumPrice: Int?, nextCursor: String?, sort: String?)
  case auctionDetail(_ auctionID: Int)
  
  var baseURL: String {
    RestAPIDefine.base(.common)
  }
  
  var domain: String? {
    switch self {
    case .auctionSearchList: nil
    case .auctionDetail: "v2/courts/"
    }
  }
  
  var path: String {
    switch self {
    case .auctionSearchList: "api/v2/search"
    case .auctionDetail(let auctionID): "sales/\(auctionID)"
    }
  }
  
  var method: Networking.HTTPMethod {
    switch self {
    case .auctionSearchList: .get
    case .auctionDetail: .get
    }
  }
  
  var queryParam: [String : Any]? {
    switch self {
    case let .auctionSearchList(keyword, region, district, buildType, auctionFailCount, varificationStatus, minimumPrice, maximumPrice, nextCursor, sort):
      var params: [String: Any] = [:]
      
      if let keyword = keyword {
        params["keyword"] = keyword
      }
      
      if let region = region {
        params["region"] = region
      } else {
        params["region"] = "ALL"
      }
      
      if let district = district {
        params["district"] = district
      }
      
      if let buildType = buildType {
        params["buildType"] = buildType
      } else {
        params["buildType"] = "ALL"
      }
      
      if let auctionFailCount = auctionFailCount {
        params["auctionFailCount"] = auctionFailCount
      } else {
        params["auctionFailCount"] = "ALL"
      }
      
      if let varificationStatus = varificationStatus {
        params["varificationStatus"] = varificationStatus
      } else {
        params["varificationStatus"] = "ALL"
      }
      
      if let minimumPrice = minimumPrice {
        params["minimumPrice"] = minimumPrice
      }
      
      if let maximumPrice = maximumPrice {
        params["maximumPrice"] = maximumPrice
      }
      
      if let nextCursor {
        params["nextCursor"] = nextCursor
      }
      
      if let sort = sort {
        params["sort"] = sort
      } else {
        params["sort"] = "LATEST_REGISTERED"
      }
      
      return params
    case .auctionDetail:
      return nil
    }
  }
  
  
}
