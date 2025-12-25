//
//  SDAuctionItem.swift
//  Domain
//
//  Created by 최수훈 on 12/21/25.
//

import SwiftData
import Foundation

@Model
final public class SDAuctionItem {
  
  @Attribute(.unique) public var salesId: Int
  
  public var caseNumber: String
  public var salesAddress: String
  
  private var salesCategoryRawValues: [String]
  public var salesCategories: [AuctionSalesCategory] {
    get {
      // String -> Enum 변환
      salesCategoryRawValues.compactMap { AuctionSalesCategory(rawValue: $0) }
    }
    set {
      // Enum -> String 변환 후 저장
      salesCategoryRawValues = newValue.map { $0.rawValue }
    }
  }
  public var salesDateTime: Date
  public var appraisalPrice: String
  
  // 부모 삭제 시 자식도 삭제
  @Relationship(deleteRule: .cascade) public var salesPictures: [SDSalesPicture]
  
  public var failBidCount: Int
  public var zzimCount: Int
  public var registerDate: Date
  public var verified: Bool
  public var isSoldOut: Bool
  
  public var createdAt: Date
  
  public init(
    salesId: Int,
    caseNumber: String,
    salesAddress: String,
    salesCategories: [AuctionSalesCategory],
    salesDateTime: Date,
    appraisalPrice: String,
    failBidCount: Int,
    zzimCount: Int,
    registerDate: Date,
    verified: Bool,
    isSoldOut: Bool,
    createdAt: Date
  ) {
    self.salesId = salesId
    self.caseNumber = caseNumber
    self.salesAddress = salesAddress
    self.salesCategoryRawValues = salesCategories.map { $0.rawValue }
    self.salesDateTime = salesDateTime
    self.appraisalPrice = appraisalPrice
    self.failBidCount = failBidCount
    self.zzimCount = zzimCount
    self.registerDate = registerDate
    self.verified = verified
    self.isSoldOut = isSoldOut
    self.salesPictures = []
    self.createdAt = Date()
  }
}

@Model
public final class SDSalesPicture {
  public var sequence: Int
  public var urlString: String
  
  public init(sequence: Int, url: URL?) {
    self.sequence = sequence
    self.urlString = url?.absoluteString ?? ""
  }
  
  public var toURL: URL? {
    return URL(string: urlString)
  }
}

