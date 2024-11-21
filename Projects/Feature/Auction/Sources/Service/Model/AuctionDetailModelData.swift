//
//  AuctionDetailModelData.swift
//  Auction
//
//  Created by 최수훈 on 11/15/24.
//

import SwiftUI

import Network

public class AuctionDetailModelData: ObservableObject {
  // TODO: - 모델 만들기
  @Published var auctionDetail: [AuctionList]?
  
  public func fetchAuctionDetail() async throws {
    let api = AuctionAPI.auctionDetail("0",
                                       "LAND", mediumCategory: "LAND_LAND",
                                      "서울중앙지방법원",
                                       salesNumber: 1)
    
    let auctionDetail = try await api.request([AuctionList].self)
    await MainActor.run { [weak self] in
      self?.auctionDetail = auctionDetail
    }
  }
}
