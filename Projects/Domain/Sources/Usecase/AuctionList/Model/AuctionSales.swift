//
//  Auction.swift
//  Domain
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

public struct AuctionSales {
  public let itmes: [AuctionSalesItem]
  public let nextCursor: String?
  public let hasNext: Bool
  
  public init(itmes: [AuctionSalesItem], nextCursor: String?, hasNext: Bool) {
    self.itmes = itmes
    self.nextCursor = nextCursor
    self.hasNext = hasNext
  }
}

public struct AuctionSalesItem: Identifiable {
  public let id: Int
  public let salesAddress: String
  public let salesCategories: [AuctionSalesCategory?]
  public let salesDate: Date
  public let appraisalPrice: String
  public let salesPictureURL: URL?
  public let failBidCount: Int
  public let zzimCount: Int
  
  public init(id: Int, salesAddress: String, salesCategories: [AuctionSalesCategory?], salesDate: Date, appraisalPrice: String, salesPictureURL: URL?, failBidCount: Int, zzimCount: Int) {
    self.id = id
    self.salesAddress = salesAddress
    self.salesCategories = salesCategories
    self.salesDate = salesDate
    self.appraisalPrice = appraisalPrice
    self.salesPictureURL = salesPictureURL
    self.failBidCount = failBidCount
    self.zzimCount = zzimCount
  }
}
