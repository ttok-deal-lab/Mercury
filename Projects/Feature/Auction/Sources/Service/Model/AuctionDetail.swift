//
//  AuctionDetail.swift
//  Auction
//
//  Created by 최수훈 on 11/16/24.
//

import Foundation


struct Auction: Decodable {
  let courtName: String
  let id: String
  let salesNumber: Int
  let auctionDetailInfo: AuctionInfo
  
  enum CodingKeys: String, CodingKey {
    case courtName
    case id = "salesId"
    case salesNumber
    case auctionDetailInfo = "courtSalesInfoDetail"
  }
}

struct AuctionInfo: Decodable {
  let courtName: String
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
  let dividenDemandDate: String
  let claimPrice: String
  let dateHistories: [String]
  let salesList: [String]
  let appraisalList: [String]
  let nearbySalesList: [String]
  
  enum CodingKeys: String, CodingKey {
    case courtName
    case id = "salesId"
    case salesNumber, salesType, assessmentPrice, lowestSalePrice, biddingMethod, salesDate, salesNote, salesLocations, inCharge, salesSubmitDate, salesOpenDate, dividenDemandDate, claimPrice, dateHistories, salesList, appraisalList, nearbySalesList
  }
}

