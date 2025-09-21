//
//  SalesType.swift
//  Domain
//
//  Created by 송하민 on 6/8/25.
//

public enum AuctionSalesCategory: String, Codable, CaseIterable {
  case building = "BUILDING"
  case commercialAndOffice = "COMMERCIAL_AND_OFFICE"
  case residentialBuilding = "RESIDENTIAL_BUILDING"
  
  public static func fromRawValue(_ rawValue: String) -> Self? {
    return AuctionSalesCategory(rawValue: rawValue)
  }
}
