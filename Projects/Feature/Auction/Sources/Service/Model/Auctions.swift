//
//  Auctions.swift
//  Auction
//
//  Created by 최수훈 on 11/4/24.
//

import Foundation

public struct AuctionInfo: Decodable, Identifiable {
    public let id: String?
    public let name: String?
    public let salesNum: Int?
    let courtInfoDetail: AuctionDetail?
    
    enum CodingKeys: String, CodingKey {
        case name = "courtName"
        case id = "salesId"
        case salesNum = "salesNumber"
        case courtInfoDetail = "courtSalesInfoDetail"
    }
}

public struct AuctionDetail: Decodable {
    var courtName: String?
    var salesId: String?
    var salesNumber: Int?
    var salesType: String?
    var assessmentPrice: String?
    var lowestSalePrice: String?
    var biddingMethod: String?
    var salesData: String?
    var salesNote: String?
    var salesLocations: [String]?
    var inCharge: String?
    var salesSubmitDate: String?
    var salesOpenDate: String?
    var dividenDemandDate: String?
    var claimPrice: String?
    var dateIstories: [String]?
    var salesList: [String]?
    var appraisalList: [String]?
    var nearBYSALESLIST: [String]?
}
