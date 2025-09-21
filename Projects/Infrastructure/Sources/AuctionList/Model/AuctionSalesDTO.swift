//
//  AuctionItemDTO.swift
//  Infrastructure
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

import Domain

struct AuctionSalesDTO: Decodable {
  let items: [AuctionSalesItemDTO]
  let nextCursor: String?
  let hasNext: Bool
}

extension AuctionSalesDTO {
  func toEntity() -> AuctionSales {
    return AuctionSales(
      itmes: items.map { $0.toEntity() },
      nextCursor: nextCursor,
      hasNext: hasNext
    )
  }
}

struct AuctionSalesItemDTO: Decodable {
  let id: Int
  let salesAddress: String
  let salesCategories: [String]
  let salesDateTime: String
  let appraisalPrice: Int64
  let salesPicture: String
  let failBidCount: Int
  let zzimCount: Int
}

extension AuctionSalesItemDTO {
  func toEntity() -> AuctionSalesItem {
    return AuctionSalesItem(
      id: id,
      salesAddress: salesAddress,
      salesCategories: salesCategories.map { AuctionSalesCategory.fromRawValue($0) },
      salesDate: salesDate,
      appraisalPrice: formattedAppraisalPrice,
      salesPictureURL: URL(string: salesPicture),
      failBidCount: failBidCount,
      zzimCount: zzimCount
    )
  }
  
  var formattedAppraisalPrice: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.locale = Locale(identifier: "ko_KR")
    
    let priceInWon = NSNumber(value: appraisalPrice)
    return formatter.string(from: priceInWon) ?? "\(appraisalPrice)"
  }
  
  var salesDate: Date {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
    return formatter.date(from: salesDateTime) ?? Date()
  }
}
