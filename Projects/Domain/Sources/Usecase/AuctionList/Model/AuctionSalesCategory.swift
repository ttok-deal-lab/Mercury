//
//  SalesType.swift
//  Domain
//
//  Created by 송하민 on 6/8/25.
//

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
