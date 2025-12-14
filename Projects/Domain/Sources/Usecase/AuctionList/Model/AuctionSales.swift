//
//  Auction.swift
//  Domain
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

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
  /// 경매 날짜
  public let salesDateTime: Date
  /// 가격
  public let appraisalPrice: String
  /// 물건 사진 정보
  public let salesPictures: [SalesPicture]
  /// 입찰실패 횟수
  public let failBidCount: Int
  /// 찜 횟수
  public let zzimCount: Int
  /// 등록 날짜
  public let registerDate: Date
  /// 인증 물건 여부
  public let verified: Bool
  /// 매각까지 남은 기간
  public let salesLeftDays: Int
  /// 매각여부
  public let isSoldOut: Bool
  
  public init(id: Int, caseNumber: String, salesAddress: String, salesCategories: [AuctionSalesCategory], salesDateTime: Date, appraisalPrice: String, salesPictures: [SalesPicture], failBidCount: Int, zzimCount: Int, registerDate: Date, verified: Bool, isSoldOut: Bool) {
    self.id = id
    self.caseNumber = caseNumber
    self.salesAddress = salesAddress
    self.salesCategories = salesCategories
    self.salesDateTime = salesDateTime
    self.appraisalPrice = appraisalPrice
    self.salesPictures = salesPictures
    self.failBidCount = failBidCount
    self.zzimCount = zzimCount
    self.registerDate = registerDate
    self.verified = verified
    let leftDays: Int = {
      let interval = Date().timeIntervalSince(salesDateTime)
      let days = Int(interval / 86400)
      return days
    }()
    self.salesLeftDays = leftDays
    self.isSoldOut = isSoldOut
  }
}
