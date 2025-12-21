//
//  AuctionDetailRepository.swift
//  Infrastructure
//
//  Created by 송하민 on 11/1/25.
//

import Foundation

import Domain

public final class AuctionDetailRepository: AuctionDetailRepositorable {
  
  public init() { }
  
  public func auctionDetail(auctionID: Int) async throws -> AuctionDetail {
    let auctionDetailDTO = try await AuctionAPI.auctionDetail(auctionID).request(AuctionDetailDTO.self)
    return auctionDetailDTO.toEntity()
  }
}
