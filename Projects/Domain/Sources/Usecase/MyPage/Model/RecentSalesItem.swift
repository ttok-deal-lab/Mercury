//
//  RecentViewSales.swift
//  Domain
//
//  Created by 최수훈 on 12/29/25.
//

import Foundation

public struct RecentSalesItem: Identifiable {
  public let id: Int
  /// 매각여부
  public let isSoldOut: Bool
  /// 건물명
  public let salesBuildingName: String?
  /// 물건 주소
  public let salesAddress: String
  /// 카테고리
  public let salesCategories: [AuctionSalesCategory]
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
  /// 매각까지 남은 기간
  public let salesLeftDays: Int
  /// 찜 여부
  public var isZzim: Bool = false
  
  public init(
    id: Int,
    isSoldOut: Bool,
    salesBuildingName: String?,
    salesAddress: String,
    salesCategories: [AuctionSalesCategory],
    salesDateTime: Date,
    appraisalPrice: String,
    salesPictures: URL?,
    failBidCount: Int,
    zzimCount: Int
  ) {
    self.id = id
    self.isSoldOut = isSoldOut
    self.salesBuildingName = salesBuildingName
    self.salesAddress = salesAddress
    self.salesCategories = salesCategories
    self.salesDateTime = salesDateTime
    self.appraisalPrice = appraisalPrice
    self.salesPictures = salesPictures
    self.failBidCount = failBidCount
    self.zzimCount = zzimCount
    let leftDays: Int = {
      let interval = Date().timeIntervalSince(salesDateTime)
      let days = Int(interval / 86400)
      return days
    }()
    self.salesLeftDays = leftDays
  }
}
