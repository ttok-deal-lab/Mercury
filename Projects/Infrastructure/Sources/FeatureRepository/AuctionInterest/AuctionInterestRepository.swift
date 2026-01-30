//
//  InterestRepository.swift
//  Infrastructure
//
//  Created by 최수훈 on 1/12/26.
//
import Foundation

import AppFoundation
import Domain

public final class AuctionInterestRepository: AuctionInterestRepositoriable {
  
  private let signininformationManager = MercuryContainer.shared.resolve(SignInInformationReadable.self)
  
  public init() { }
  
  public func isAuctionUserInterested(auctionID: Int) async throws -> Bool {
    // TODO: - 구현
    return true
  }
  
  public func addUserInterestAuction(auctionID: Int) async throws {
    
  }
  
  public func removeUserInterestAuction(userID: String, auctionID: Int) async throws {
    try await AuctionInterestAPI
      .removeUserInterestAuction(userID: userID, auctionID: auctionID)
      .request()
  }
  
  public func fetchUserInterestAuctions() async throws -> InterestSales {
    guard let userID = signininformationManager.userInfo?.id else {
      throw MercuryError(.notFoundUser)
    }
    
    // TODO: - type, cursor
    let interestSalesDTO = try await AuctionInterestAPI
      .fetchUserInterestAuctions(
        userID: "\(userID)",
        type: nil,
        nextCursor: "",
        size: nil
      )
      .request(InterestSalesDTO.self)
    let interestItemList = interestSalesDTO.toEntity()
    print(interestItemList)
    
    return interestItemList
  }
  
}
