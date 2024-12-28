//
//  AuctionList.swift
//  Auction
//
//  Created by 최수훈 on 11/4/24.
//

import Foundation

public struct AuctionList: Decodable, Hashable {
  let courtName: String
  let id: String
  let salesNumber: Int
  let auctionListInfo: AuctionListInfo?
  
  enum CodingKeys: String, CodingKey {
    case courtName
    case id = "salesId"
    case salesNumber
    case auctionListInfo = "courtSalesInfoDetail"
  }
}

public struct AuctionListInfo: Decodable, Hashable {
  let courtName: String
  let salesID: String
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
  let dateHistories: [String]
  let salesList: [String]
  let appraisalList: [String]
  let nearbySalesList: [String]
  
  enum CodingKeys: String, CodingKey {
    case courtName
    case salesID = "salesId"
    case salesNumber, salesType, assessmentPrice, lowestSalePrice, biddingMethod, salesData, salesNote, salesLocations, inCharge, salesSubmitDate, salesOpenDate, dividenDemandDate, claimPrice, dateHistories, salesList, appraisalList, nearbySalesList
  }
}
