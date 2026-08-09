//
//  AuctionTypes.swift
//  Domain
//
//  Created by 송하민 on 11/2/25.
//

public enum AuctionSalesCategory: String, CaseIterable {
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
  // 서버가 구체 용도와 함께 내려주는 상위 분류. 없으면 compactMap 에서 전부 걸러져 칩이 사라진다.
  case housing = "HOUSING"
  case building = "BUILDING"
  case residential_building = "RESIDENTIAL_BUILDING"
  case land_designation = "LAND_DESIGNATION"
  case building_site = "BUILDING_SITE"

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
