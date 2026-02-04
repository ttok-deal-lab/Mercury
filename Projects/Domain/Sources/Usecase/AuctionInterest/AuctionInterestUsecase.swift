//
//  AuctionInterestUsecase.swift
//  Domain
//
//  Created by 최수훈 on 1/20/26.
//

final public class AuctionInterestUsecase: AuctionInterestUsecasable {

  private let fetcher: AuctionInterestFetcher
  
  public init(repository: AuctionInterestRepositoriable) {
    self.fetcher = AuctionInterestFetcher(repository: repository)
  }
  
  public func isAuctionUserInterested(auctionID: Int) async throws -> Bool {
    return try await fetcher.isAuctionUserInterested(auctionID: auctionID)
  }
  
  public func addUserInterestAuction(auctionID: Int) async throws {
    try await fetcher.addUserInterestAuction(auctionID: auctionID)
  }
  
  public func removeUserInterestAuction(auctionID: Int) async throws {
    try await fetcher.removeUserInterestAuction(auctionID: auctionID)
  }
  
  public func loadUserInterestAuctions() async throws -> [InterestItem] {
    return try await fetcher.fetchUserInterestAuctions()
  }
  
  public func loadNextInterestAuctions() async throws -> [InterestItem] {
    return []
  }

  public func loadInterestAuctionList(ids: [Int]) async throws -> [InterestWhether] {
    return try await fetcher.loadInterestAuctionList(ids: ids)
  }
}

actor AuctionInterestFetcher {
  private let repository: AuctionInterestRepositoriable
  private var cursor: String?
  private var hasNext: Bool = true
  private var isLoding: Bool = false
  
  init(repository: AuctionInterestRepositoriable) {
    self.repository = repository
  }
  
  func isAuctionUserInterested(auctionID: Int) async throws -> Bool {
    let isZzim = try await repository.isAuctionUserInterested(auctionID: auctionID)
    return isZzim
  }
  
  func addUserInterestAuction(auctionID: Int) async throws {
    try await repository.addUserInterestAuction(auctionID: auctionID)
  }
  
  func removeUserInterestAuction(auctionID: Int) async throws {
    // TODO: - 유저정보 가지고오기
    try await repository.removeUserInterestAuction(auctionID: auctionID)
  }
  
  func fetchUserInterestAuctions() async throws -> [InterestItem] {
    let interestSales = try await repository.fetchUserInterestAuctions()
    return interestSales.items
  }
  
  func fetchNextInterestAuctions() async throws -> [InterestItem] {
    return []
  }
  
  func loadInterestAuctionList(ids: [Int]) async throws -> [InterestWhether] {
    return try await repository.fetchInterestAuctionList(ids: ids)
  }
}
