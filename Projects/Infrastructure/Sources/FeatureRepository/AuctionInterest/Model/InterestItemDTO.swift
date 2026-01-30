//
//  InterestItemDTO.swift
//  Infrastructure
//
//  Created by 최수훈 on 1/12/26.
//

import Foundation

import AppFoundation
import Domain

struct InterestSalesDTO: Decodable, Sendable {
  let nextCursor: String?
  let hasNext: Bool
  let items: [InterestItemDTO]
}

extension InterestSalesDTO {
  func toEntity() -> InterestSales {
    return InterestSales(
      nextCursor: nextCursor,
      hasNext: hasNext,
      items: items.map { $0.toEntity() }
    )
  }
}

struct InterestItemDTO: Decodable, Sendable {
  let id: Int
  let salesBuildingName: String?
  let salesAddress: String
  let salesCategories: [String]
  let salesDateTime: String
  let salesPicture: String
  let appraisalPrice: Int
  let failBidCount: Int
  let zzimCount: Int
  let isSoldOut: Bool
  
  enum CodingKeys: String, CodingKey {
    case id
    case salesBuildingName, salesAddress, salesCategories, salesDateTime, salesPicture, appraisalPrice
    case failBidCount, zzimCount
    case isSoldOut
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.salesBuildingName = try container.decode(String?.self, forKey: .salesBuildingName)
    self.salesAddress = try container.decode(String.self, forKey: .salesAddress)
    self.salesCategories = try container.decode([String].self, forKey: .salesCategories)
    self.salesDateTime = try container.decode(String.self, forKey: .salesDateTime)
    self.salesPicture = try container.decode(String.self, forKey: .salesPicture)
    self.appraisalPrice = try container.decode(Int.self, forKey: .appraisalPrice)
    self.failBidCount = try container.decode(Int.self, forKey: .failBidCount)
    self.zzimCount = try container.decode(Int.self, forKey: .zzimCount)
    self.isSoldOut = try container.decode(Bool.self, forKey: .isSoldOut)
  }
}

extension InterestItemDTO {
  func toEntity() -> InterestItem {
    return InterestItem(
      id: id,
      salesBuildingName: salesBuildingName,
      salesAddress: salesAddress,
      salesCategories: salesCategories.compactMap { AuctionSalesCategory.fromRawValue($0) },
      salesDateTime: salesDateTime.toKoreanDate(),
      appraisalPrice: appraisalPrice.toKoreanWon,
      salesPictures: URL(string: salesPicture),
      failBidCount: failBidCount,
      zzimCount: zzimCount,
      isSoldOut: isSoldOut
    )
  }
}
