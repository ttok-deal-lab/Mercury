//
//  ApplyingAuctionSearchFilter.swift
//  AuctionHome
//
//  Created by 송하민 on 12/14/25.
//

/// 적용중인 필터
public struct ApplyingAuctionSearchFilter {
  public var keyword: String?
  public var regionCode: String?
  public var districtCode: String?
  public var buildType: String?
  public var auctionFailCount: Int?
  public var varificationStatus: String?
  public var minimumPrice: Int?
  public var maximumPrice: Int?
  public var sort: String?
  
  public init() {
    
  }
}
