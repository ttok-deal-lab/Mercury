//
//  AuctionInterestUsecase.swift
//  Domain
//
//  Created by 최수훈 on 1/20/26.
//

final public class AuctionInterestUsecase: AuctionInterestUsecasable {
  private let repository: AuctionInterestRepositoriable
  
  public init(repository: AuctionInterestRepositoriable) {
    self.repository = repository
  }
  
  public func isAuctionUserInterested(auctionID: Int) async throws -> Bool {
    let isZzim = try await repository.isAuctionUserInterested(auctionID: auctionID)
    return isZzim
  }
  
  public func addUserInterestAuction(auctionID: Int) async throws {
    try await repository.addUserInterestAuction(auctionID: auctionID)
  }
  
  public func removeUserInterestAuction(auctionID: Int) async throws {
    // TODO: - 유저정보 가지고오기
    try await repository.removeUserInterestAuction(auctionID: auctionID)
  }
  
  public func fetchUserInterestAuctions() async throws -> [InterestItem] {
    let interestSales = try await repository.fetchUserInterestAuctions()
    return interestSales.items
  }
  
  
}
