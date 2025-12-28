//
//  AuctionDetailUsecase.swift
//  Domain
//
//  Created by 송하민 on 11/1/25.
//

import Foundation

public final class AuctionDetailUsecase: AuctionDetailUsecasable {
  
  private let auctionDetailRepositorable: AuctionDetailRepositorable
  
  public init(auctionDetailRepositorable: AuctionDetailRepositorable) {
    self.auctionDetailRepositorable = auctionDetailRepositorable
  }
  
  public func fetchAuctionDetail(auctionID: Int) async throws -> AuctionDetail {
    try await self.auctionDetailRepositorable.auctionDetail(auctionID: auctionID)
  }
  
  public func fetchAuctionDetails(auctionIDs: [Int], size: Int) async throws -> [AuctionDetail] {
    try await self.auctionDetailRepositorable.auctionDetails(auctionIDs: auctionIDs, size: size)
  }
  
}
