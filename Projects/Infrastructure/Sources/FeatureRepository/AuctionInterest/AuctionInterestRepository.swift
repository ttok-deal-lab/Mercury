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
  
  private let signinInformationManager = MercuryContainer.shared.resolve(SignInInformationReadable.self)
  
  public init() { }
  
  private func getUserID() throws -> Int {
    guard let userID = signinInformationManager.userInfo?.id else {
      throw MercuryError(.notFoundUser)
    }
    return userID
  }
  
  public func isAuctionUserInterested(auctionID: Int) async throws -> Bool {
    let userID = try getUserID()
    let isZzim = try await AuctionInterestAPI.isAuctionUserInterested(
      userID: userID,
      auctionID: auctionID
    ).request(Bool.self)
    return isZzim
  }
  
  public func addUserInterestAuction(auctionID: Int) async throws {
    let userID = try getUserID()
    try await AuctionInterestAPI.addUserInterestAuction(
      userID: userID,
      auctionID: auctionID
    )
    .request()
  }
  
  public func removeUserInterestAuction(auctionID: Int) async throws {
    let userID = try getUserID()
    try await AuctionInterestAPI
      .removeUserInterestAuction(
        userID: userID,
        auctionID: auctionID
      )
      .request()
  }
  
  public func fetchUserInterestAuctions() async throws -> InterestSales {
    let userID = try getUserID()
    // TODO: - type, cursor
    let interestSalesDTO = try await AuctionInterestAPI
      .fetchUserInterestAuctions(
        userID: userID,
        type: nil,
        nextCursor: "",
        size: nil
      )
      .request(InterestSalesDTO.self)
    let interestItemList = interestSalesDTO.toEntity()
    
    return interestItemList
  }
  
}
