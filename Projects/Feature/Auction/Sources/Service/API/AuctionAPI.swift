//
//  AuctionAPI.swift
//  Auction
//
//  Created by 최수훈 on 11/6/24.
//

import Foundation

import Network

public enum AuctionAPI: BaseAPI {
  case auctionList(_ largeCategory: String, mediumCategory: String, page: Int)
  case auctionDetail(_ salesId: String, _ largeCategory: String, mediumCategory: String, _ courtName: String, salesNumber: Int)
  
  public var baseURL: String {
    "http://sherbet-api.dev.pursue503.com/v1/"
  }
  
  public var domain: String? {
    switch self {
    case .auctionList, .auctionDetail: "sales/"
    }
  }
  
  
  public var path: String {
    switch self {
    case .auctionList: "court"
    case .auctionDetail(let salesId, _, _, _, _): "court/\(salesId)"
    }
  }
  
  public var method: Network.HTTPMethod {
    switch self {
    case .auctionList, .auctionDetail: .get
    }
  }
  
  public var queryParam: [URLQueryItem]? {
    switch self {
    case let .auctionList(largeCategory, mediumCategory, page):
      return [
        .init(name: "largeCategory", value: largeCategory),
        .init(name: "mediumCategory", value: mediumCategory),
        .init(name: "page", value: "\(page)")
      ]
    case .auctionDetail(_, let largeCategory, let mediumCategory, let courtName, let salesNumber):
      return [
        .init(name: "largeCategory", value: largeCategory),
        .init(name: "mediumCategory", value: mediumCategory),
        .init(name: "courtName", value: courtName),
        .init(name: "salesNumber", value: "\(salesNumber)")
      ]
    }
  }
  
  
}
