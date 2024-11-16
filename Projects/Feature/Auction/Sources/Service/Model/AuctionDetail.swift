//
//  AuctionDetail.swift
//  Auction
//
//  Created by 최수훈 on 11/16/24.
//

import Foundation


struct AuctionDetail: Decodable {
  let name: String
  let id: String
  let salesNumber: Int
  let auctionDetailInfo: AuctionDetailInfo
  
  enum CodingKeys: String, CodingKey {
    case name = "courtName"
    case id = "salesId"
    case salesNumber
    case auctionDetailInfo = "courtSalesInfoDetail"
  }
}

struct AuctionDetailInfo: Decodable {
  let name: String
  let id: String
  let salesNumber: Int
  let salesType: String
  let assessmentPrice: String
  let lowestSalePrice: String
  let biddingMethod: String
  let salesDate, salesNote: String
  let salesLocations: [String]
  let inCharge: String
  let salesSubmitDate: String
  let salesOpenDate: String
  let dividendDemandDate: String
  let claimPrice: String
  let dateHistories: [String]
  let salesList: [String]
  let appraisalList: [String]
  let nearbySalesList: [String]
  
  enum CodingKeys: String, CodingKey {
    case name = "courtName"
    case id = "salesId"
    case salesNumber, salesType, assessmentPrice, lowestSalePrice, biddingMethod, salesDate, salesNote, salesLocations, inCharge, salesSubmitDate, salesOpenDate, dividendDemandDate, claimPrice, dateHistories, salesList, appraisalList, nearbySalesList
  }
}

