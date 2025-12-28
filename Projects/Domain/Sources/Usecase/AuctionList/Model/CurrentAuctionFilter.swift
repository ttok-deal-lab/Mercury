//
//  CurrentAuctionFilter.swift
//  AuctionHome
//
//  Created by 송하민 on 12/14/25.
//

/// 적용중인 필터
public struct CurrentAuctionFilter {
  /// 검색어
  public var keyword: String?
  /// 상위 지역
  public var region: Region?
  /// 하위 지역
  public var district: District?
  /// 건물 타입
  public var buildingTypeCodes: Set<String>?
  /// 유찰 횟수
  public var auctionFailCodes: Set<String>?
  /// 최대가격
  public var minimumPrice: Int?
  /// 최소가격
  public var maximumPrice: Int?
  /// 정렬
  public var sort: Option?
  /// 인증여부
  public var isCertified: Bool = false
  /// 낙찰여부
  public var isBidWon: Bool = false
  
  public init() {
    
  }
  
  public mutating func clear() {
    self.keyword = nil
    self.region = nil
    self.buildingTypeCodes = nil
    self.auctionFailCodes = nil
    self.minimumPrice = nil
    self.maximumPrice = nil
    self.sort = nil
    self.isCertified = false
    self.isBidWon = false
  }
}
