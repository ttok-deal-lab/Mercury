//
//  Auction.swift
//  Domain
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

public struct AuctionSales {
  public let items: [AuctionSalesItem]
  public let nextCursor: String?
  public let hasNext: Bool
  
  public init(items: [AuctionSalesItem], nextCursor: String?, hasNext: Bool) {
    self.items = items
    self.nextCursor = nextCursor
    self.hasNext = hasNext
  }
}

public struct AuctionSalesItem: Identifiable {
  public let id: Int
  /// 물건 주소
  public let salesAddress: String
  /// ???
  public let itemTypes: [AuctionSalesItemType?]
  /// 카테고리 ??
  public let salesCategories: [AuctionSalesCategory?]
  /// 날짜?
  public let salesDate: Date
  /// 가격
  public let appraisalPrice: String
  /// 물건 사진 URL
  public let salesPictureURL: URL?
  /// 입찰실패 횟수
  public let failBidCount: Int
  /// 찜 횟수
  public let zzimCount: Int
  
  public init(id: Int, salesAddress: String, itemTypes: [AuctionSalesItemType?], salesCategories: [AuctionSalesCategory?], salesDate: Date, appraisalPrice: String, salesPictureURL: URL?, failBidCount: Int, zzimCount: Int) {
    self.id = id
    self.salesAddress = salesAddress
    self.itemTypes = itemTypes
    self.salesCategories = salesCategories
    self.salesDate = salesDate
    self.appraisalPrice = appraisalPrice
    self.salesPictureURL = salesPictureURL
    self.failBidCount = failBidCount
    self.zzimCount = zzimCount
  }
}

public enum AuctionSalesCategory: String, Codable, CaseIterable {
  case apartment = "APARTMENT"
  case detached_house = "DETACHED_HOUSE"
  case multi_household = "MULTI_HOUSEHOLD"
  case row_house = "ROW_HOUSE"
  case multi_family = "MULTI_FAMILY"
  case villa = "VILLA"
  case automobile = "AUTOMOBILE"
  case heavy_equipment = "HEAVY_EQUIPMENT"
  case land = "LAND"
  case forest = "FOREST"
  case farmland = "FARMLAND"
  case commercial = "COMMERCIAL"
  case office_tel = "OFFICE_TEL"
  case neighborhood_facility = "NEIGHBORHOOD_FACILITY"
  case other = "OTHER"
  
  public static func fromRawValue(_ rawValue: String) -> Self? {
    return AuctionSalesCategory(rawValue: rawValue)
  }
}

public enum AuctionSalesItemType: String {
  case housing = "HOUSING"
  case villa = "VILLA"
  case apartment = "APARTMENT"
  case shop_house = "SHOP_HOUSE"
  case officetel = "OFFICETEL"
  case other = "OTHER"
  
  public static func fromRawValue(_ rawValue: String) -> Self? {
    return AuctionSalesItemType(rawValue: rawValue)
  }
}

/// 경매상태
public enum AuctionStatusType {
  case all
  /// 신건
  case new
  /// 기일 변경 중
  case changingDueDate
  /// 유찰
  case outbid
}
