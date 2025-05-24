//
//  AuctionAPI.swift
//  Auction
//
//  Created by 최수훈 on 11/6/24.
//

import Foundation

import Networking

enum AuctionAPI: BaseAPI {
  case auctionList(courtName: String)
  case auctionDetail(_ salesId: String, _ largeCategory: String, mediumCategory: String, _ courtName: String, salesNumber: Int)
  
  var baseURL: String {
    RestAPIDefine.base(.common)
  }
  
  var domain: String? {
    switch self {
    case .auctionList, .auctionDetail: "v1/courts/"
    }
  }
  
  var path: String {
    switch self {
    case .auctionList: "sales"
    case .auctionDetail(let salesId, _, _, _, _): "court/\(salesId)"
    }
  }
  
  var method: Networking.HTTPMethod {
    switch self {
    case .auctionList, .auctionDetail: .get
    }
  }
  
  var queryParam: [String : Any]? {
    switch self {
    case let .auctionList(courtName):
      return [
        "courtName": courtName
      ]
    case .auctionDetail(_, let largeCategory, let mediumCategory, let courtName, let salesNumber):
      return [
        "largeCategory": "\(largeCategory)",
        "mediumCategory": "\(mediumCategory)",
        "courtName": "\(courtName)",
        "salesNumber": "\(salesNumber)"
      ]
    }
  }
  
  
}
