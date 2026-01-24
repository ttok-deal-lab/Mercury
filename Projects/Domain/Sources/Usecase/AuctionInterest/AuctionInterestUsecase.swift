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
      return true
  }

  public func addUserInterestAuction(auctionID: Int) async throws {
    
  }

  public func removeUserInterestAuction(auctionID: Int) async throws {
    try await repository.removeUserInterestAuction(userID: "", auctionID: auctionID)
  }

  public func fetchUserInterestAuctions() async throws -> [AuctionSales] {
    return .init()
  }

  
}
