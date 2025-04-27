//
//  AuctionAPI.swift
//  Auction
//
//  Created by 최수훈 on 11/6/24.
//

import Foundation

import Networking

enum AuctionAPI: BaseAPI {
  case auctionList(_ largeCategory: String, mediumCategory: String, page: Int)
  case auctionDetail(_ salesId: String, _ largeCategory: String, mediumCategory: String, _ courtName: String, salesNumber: Int)
  
  var baseURL: String {
    RestAPIDefine.base(.common)
  }
  
  var domain: String? {
    switch self {
    case .auctionList, .auctionDetail: "sales/"
    }
  }
  
  var path: String {
    switch self {
    case .auctionList: "court"
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
    case let .auctionList(largeCategory, mediumCategory, page):
      return [
        "largeCategory": largeCategory,
        "mediumCategory": mediumCategory,
        "page": "\(page)"
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
