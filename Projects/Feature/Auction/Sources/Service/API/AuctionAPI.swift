//
//  AuctionAPI.swift
//  Auction
//
//  Created by 최수훈 on 11/6/24.
//

import Foundation

import Network

public enum AuctionAPI: BaseAPI {
    case auctionList
    case auctionDetail(_ salesId: String)
    public var baseURL: String {
        "http://sherbet-api.dev.pursue503.com/v1/"
    }
    
    public var domain: String {
        switch self {
        case.auctionList: "sales/"
        case .auctionDetail(_): "sales/"
        }
    }
    
    public var path: String {
        switch self {
        case .auctionList: "court"
        case .auctionDetail(let salesId): "court/\(salesId)"
        }
    }
    
    public var method: Network.HTTPMethod {
        switch self {
        case .auctionList, .auctionDetail: .get
        }
    }

    
}
