//
//  Auction.swift
//  Domain
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

import AppFoundation

public struct AuctionSales {
  public let searchHitCount: Int
  public let items: [AuctionSalesItem]
  public let nextCursor: String?
  
  public init(searchHitCount: Int, items: [AuctionSalesItem], nextCursor: String?) {
    self.searchHitCount = searchHitCount
    self.items = items
    self.nextCursor = nextCursor
  }
}

public struct AuctionSalesItem: Identifiable {
  public let id: Int
  /// 경매 번호
  public let caseNumber: String
  /// 물건 주소
  public let salesAddress: String
  /// 카테고리
  public let salesCategories: [AuctionSalesCategory]
  /// 건물 이름
  public let salesBuildingName: String?
  /// 경매 날짜
  public let salesDateTime: Date
  /// 가격
  public let appraisalPrice: String
  /// 물건 사진 정보
  public let salesPictures: URL?
  /// 입찰실패 횟수
  public let failBidCount: Int
  /// 찜 횟수
  public var zzimCount: Int
  /// 등록 날짜
  public let registerDate: Date
  /// 매각일 기준 D-day 오프셋 (미래: 음수 `D-n`, 당일: `0`, 과거: 양수 `D+n`)
  public let salesLeftDays: Int
  /// 인증 물건 여부
  public let verified: Bool
  /// 매각여부
  public let isSoldOut: Bool
  /// 찜 여부
  public var isZzim: Bool = false
  
  public init(
    id: Int,
    caseNumber: String,
    salesAddress: String,
    salesCategories: [AuctionSalesCategory],
    salesBuildingName: String?,
    salesDateTime: Date,
    appraisalPrice: String,
    salesPictures: URL?,
    failBidCount: Int,
    zzimCount: Int,
    registerDate: Date,
    verified: Bool,
    isSoldOut: Bool
  ) {
    self.id = id
    self.caseNumber = caseNumber
    self.salesAddress = salesAddress
    self.salesCategories = salesCategories
    self.salesBuildingName = salesBuildingName
    self.salesDateTime = salesDateTime
    self.appraisalPrice = appraisalPrice
    self.salesPictures = salesPictures
    self.failBidCount = failBidCount
    self.zzimCount = zzimCount
    self.registerDate = registerDate
    self.verified = verified
    self.salesLeftDays = salesDateTime.dDayOffset()
    self.isSoldOut = isSoldOut
  }
}
