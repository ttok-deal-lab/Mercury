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
  
  public func auctionDetails(auctionIDs: [Int], size: Int = 5) async throws -> [AuctionDetail] {
    var results: [AuctionDetail] = []
    results.reserveCapacity(auctionIDs.count)
    
    for startIndex in stride(from: 0, to: auctionIDs.count, by: size) {
      let endIndex = min(startIndex + size, auctionIDs.count)
      let currentIDs = auctionIDs[startIndex..<endIndex]
      
      try await withThrowingTaskGroup(of: AuctionDetail.self) { group in
        for id in currentIDs {
          group.addTask {
            let dto = try await AuctionAPI.auctionDetail(id).request(AuctionDetailDTO.self)
            return dto.toEntity()
          }
        }
        
        for try await detail in group {
          results.append(detail)
        }
      }
    }
    
    return results
  }
}
