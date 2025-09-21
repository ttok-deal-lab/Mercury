//
//  AuctionSalesItemType.swift
//  Domain
//
//  Created by 송하민 on 9/21/25.
//

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
