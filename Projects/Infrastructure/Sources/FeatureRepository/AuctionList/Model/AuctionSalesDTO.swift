//
//  AuctionItemDTO.swift
//  Infrastructure
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

import AppFoundation
import Domain

struct AuctionSalesDTO: Decodable, Sendable {
  let searchHitCount: Int
  let auctionItemResponses: [AuctionSalesItemDTO]
  let nextCursor: String?
}

extension AuctionSalesDTO {
  func toEntity() -> AuctionSales {
    return AuctionSales(
      searchHitCount: searchHitCount,
      items: auctionItemResponses.map { $0.toEntity() },
      nextCursor: nextCursor
    )
  }
}

struct AuctionSalesItemDTO: Decodable, Sendable {
  let id: Int
  let salesAddress: String
  let salesCategories: [String]
  let salesDateTime: String
  let appraisalPrice: Int
  let failBidCount: Int
  let zzimCount: Int
  let caseNumber: String
  let salesPicture: [SalesPictureDTO]
  let registerDate: String
  let verified: Bool
  
  enum CodingKeys: String, CodingKey {
    case id, caseNumber, salesAddress, salesCategories
    case salesDateTime, appraisalPrice, salesPicture
    case failBidCount, zzimCount, registerDate, verified
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    id = try container.decode(Int.self, forKey: .id)
    caseNumber = try container.decode(String.self, forKey: .caseNumber)
    salesAddress = try container.decode(String.self, forKey: .salesAddress)
    salesCategories = try container.decode([String].self, forKey: .salesCategories)
    appraisalPrice = try container.decode(Int.self, forKey: .appraisalPrice)
    salesPicture = try container.decode([SalesPictureDTO].self, forKey: .salesPicture)
    failBidCount = try container.decode(Int.self, forKey: .failBidCount)
    zzimCount = try container.decode(Int.self, forKey: .zzimCount)
    verified = try container.decode(Bool.self, forKey: .verified)
    salesDateTime = try container.decode(String.self, forKey: .salesDateTime)
    registerDate = try container.decode(String.self, forKey: .registerDate)
  }
}

extension AuctionSalesItemDTO {
  func toEntity() -> AuctionSalesItem {
    return AuctionSalesItem(
      id: id,
      caseNumber: caseNumber,
      salesAddress: salesAddress,
      salesCategories: salesCategories.compactMap { AuctionSalesCategory.fromRawValue($0) },
      salesDateTime: salesDateTime.toKoreanDate(),
      appraisalPrice: appraisalPrice.toKoreanPriceFormat(),
      salesPictures: salesPicture.map { SalesPicture(sequence: $0.sequence, url: URL(string: $0.imageUrl)) },
      failBidCount: failBidCount,
      zzimCount: zzimCount,
      registerDate: registerDate.toKoreanDate(),
      verified: verified
    )
  }
}
