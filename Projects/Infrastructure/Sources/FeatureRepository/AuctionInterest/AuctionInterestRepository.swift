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
  
  // 단일물건 관심여부
  public func isAuctionInterested(auctionID: Int) async throws -> Bool {
    let userID = try getUserID()
    let isZzim = try await AuctionInterestAPI.isAuctionInterested(
      userID: userID,
      auctionID: auctionID
    ).request(Bool.self)
    return isZzim
  }
  
  public func addInterest(auctionID: Int) async throws {
    let userID = try getUserID()
    try await AuctionInterestAPI.addInterest(
      userID: userID,
      auctionID: auctionID
    )
    .request()
  }
  
  public func removeInterest(auctionID: Int) async throws {
    let userID = try getUserID()
    try await AuctionInterestAPI
      .removeInterest(
        userID: userID,
        auctionID: auctionID
      )
      .request()
  }
  
  // 관심 탭 리스트
  public func fetchInterest(
    type: String?,
    cursor: String?
  ) async throws -> InterestSales {
    let userID = try getUserID()
    // TODO: - type, cursor
    let interestSalesDTO = try await AuctionInterestAPI
      .fetchInterest(
        userID: userID,
        type: type,
        nextCursor: cursor
      )
      .request(InterestSalesDTO.self)
    let interestItemList = interestSalesDTO.toEntity()
    
    return interestItemList
  }
  
  public func fetchInterestList(ids: [Int]) async throws -> [InterestWhether] {
    let userID = try getUserID()
    let interestWhetherDTO = try await AuctionInterestAPI.fetchInterestList(
      userID: userID,
      ids: ids
    )
      .request([InterestWhetherDTO].self)
    
    let interestWhether = interestWhetherDTO.map { $0.toEntity() }
    
    return interestWhether
  }
}
