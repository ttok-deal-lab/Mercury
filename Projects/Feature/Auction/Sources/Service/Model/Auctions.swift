//
//  Auctions.swift
//  Auction
//
//  Created by 최수훈 on 11/4/24.
//

import Foundation

public struct AuctionInfo: Decodable {
  let id: String
  let name: String
  let salesNum: Int
  let courtInfoDetail: AuctionDetail?
  
  enum CodingKeys: String, CodingKey {
    case name = "courtName"
    case id = "salesId"
    case salesNum = "salesNumber"
    case courtInfoDetail = "courtSalesInfoDetail"
  }
}

public struct AuctionDetail: Decodable {
  let courtName: String
  let salesId: String
  let salesNumber: Int
  let salesType: String
  let assessmentPrice: String
  let lowestSalePrice: String
  let biddingMethod: String
  let salesData: String
  let salesNote: String
  let salesLocations: [String]
  let inCharge: String
  let salesSubmitDate: String
  let salesOpenDate: String
  let dividenDemandDate: String
  let claimPrice: String
  let dateIstories: [String]
  let salesList: [String]
  let appraisalList: [String]
  let nearBYSALESLIST: [String]
}
