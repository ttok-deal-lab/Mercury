//
//  RecentViewSalesDTO.swift
//  Infrastructure
//
//  Created by 최수훈 on 12/29/25.
//

import Foundation

import AppFoundation
import Domain

struct RecentSalesItemDTO: Decodable, Sendable {
  let id: Int
  let isSoldOut: Bool
  let verified: Bool
  let salesBuildingName: String
  let salesAddress: String
  let salesCategories: [String]
  let salesDateTime: String
  let appraisalPrice: Int
  let failBidCount: Int
  let zzimCount: Int
  let salesPicture: String
  
  
  enum CodingKeys: String, CodingKey {
    case id, salesAddress, salesCategories
    case salesDateTime, appraisalPrice, salesPicture
    case failBidCount, zzimCount
    case isSoldOut, verified, salesBuildingName
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.isSoldOut = try container.decode(Bool.self, forKey: .isSoldOut)
    self.verified = try container.decode(Bool.self, forKey: .verified)
    self.salesBuildingName = try container.decode(String.self, forKey: .salesBuildingName)
    self.salesAddress = try container.decode(String.self, forKey: .salesAddress)
    self.salesCategories = try container.decode([String].self, forKey: .salesCategories)
    self.salesDateTime = try container.decode(String.self, forKey: .salesDateTime)
    self.appraisalPrice = try container.decode(Int.self, forKey: .appraisalPrice)
    self.failBidCount = try container.decode(Int.self, forKey: .failBidCount)
    self.zzimCount = try container.decode(Int.self, forKey: .zzimCount)
    self.salesPicture = try container.decode(String.self, forKey: .salesPicture)
  }
}

extension RecentSalesItemDTO {
  func toEntity() -> RecentSalesItem {
    return RecentSalesItem(
      id: id,
      isSoldOut: isSoldOut,
      verified: verified,
      salesBuildingName: salesBuildingName,
      salesAddress: salesAddress,
      salesCategories: salesCategories.compactMap { AuctionSalesCategory.fromRawValue($0) },
      salesDateTime: salesDateTime.toKoreanDate(),
      appraisalPrice: appraisalPrice.toKoreanWon,
      salesPictures: URL(string: salesPicture),
      failBidCount: failBidCount,
      zzimCount: zzimCount
    )
  }
}
