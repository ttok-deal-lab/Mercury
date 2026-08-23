//
//  AuctionAPI.swift
//  Auction
//
//  Created by 최수훈 on 11/6/24.
//

import Foundation

import AppFoundation
import Domain
import Networking

enum AuctionAPI: BaseAPI {
  case auctionSearchList(keyword: String?, region: String?, district: String?, buildTypes: [String]?, auctionFailCount: [String]?, isCertified: Bool?, isBidWon: Bool?, minimumPrice: Int?, maximumPrice: Int?, nextCursor: String?, sort: String?, size: Int?)
  case auctionDetail(_ auctionID: Int)
  case auctionSales(auctionIDs: [Int])
  case auctionSearchFilter
  
  var baseURL: String {
    RestAPIDefine.base(.common)
  }
  
  var domain: String? {
    switch self {
    case .auctionSearchList: "api/v2/"
    case .auctionDetail, .auctionSales: "v2/courts/"
    case .auctionSearchFilter: "api/v1/"
    }
  }
  
  var path: String {
    switch self {
    case .auctionSearchList:
      return "search"
    case .auctionDetail(let auctionID):
      return "sales/\(auctionID)"
    case .auctionSales(let auctionIDs):
      let queryString = auctionIDs
        .map { "ids=\($0)" }
        .joined(separator: "&")
      return "sales?\(queryString)"
    case .auctionSearchFilter:
      return "search/filters"
    }
  }
  
  var method: Networking.HTTPMethod {
    switch self {
    case .auctionSearchList: .get
    case .auctionDetail: .get
    case .auctionSales: .get
    case .auctionSearchFilter: .get
    }
  }

  var headers: [String: String]? {
    ["Authorization": MercuryContainer.shared.resolve(SignInInformationReadable.self).accessToken?.value ?? ""]
  }
  
  var queryParam: [String : Any]? {
    switch self {
    case let .auctionSearchList(keyword, region, district, buildTypes, auctionFailCount, isCertified, isBidWon, minimumPrice, maximumPrice, nextCursor, sort, size):
      var params: [String: Any] = [:]
      
      params["keyword"] = keyword ?? "unknown"
      
      if let region = region {
        params["region"] = region
      } else {
        params["region"] = "ALL"
      }
      
      if let district = district {
        if district.lowercased() == "unknown" {
          params["district"] = "unknown"
        } else {
          params["district"] = district
        }
      } else {
        params["district"] = "unknown"
      }
      
      // 서버 스펙(OpenAPI): `buildType` 은 `type: array` — 반복 키 직렬화.
      // Set→Array 변환의 무작위 순서를 `.sorted()` 로 안정화한다 (URL 캐시 친화적).
      if let buildTypes = buildTypes, !buildTypes.isEmpty {
        params["buildType"] = buildTypes.sorted()
      } else {
        params["buildType"] = ["ALL"]
      }

      if let auctionFailCount = auctionFailCount, !auctionFailCount.isEmpty {
        params["auctionFailCount"] = auctionFailCount.sorted()
      } else {
        params["auctionFailCount"] = ["ALL"]
      }
      
      if let isCertified = isCertified {
        params["verificationStatus"] = isCertified ? "VERIFIED" : "ALL"
      } else {
        params["verificationStatus"] = "ALL"
      }

      // 낙찰 필터는 단일 토글: 켜면 매각 완료 매물만, 끄면 전체.
      if let isBidWon = isBidWon {
        params["soldOutStatus"] = isBidWon ? "SOLD_OUT" : "ALL"
      } else {
        params["soldOutStatus"] = "ALL"
      }

      params["minimumPrice"] = minimumPrice ?? -1
      
      params["maximumPrice"] = maximumPrice ?? -1
      
      if let size {
        params["size"] = size
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
    case .auctionSales:
      return nil
    case .auctionSearchFilter:
      return nil
    }
  }
  
  
}
