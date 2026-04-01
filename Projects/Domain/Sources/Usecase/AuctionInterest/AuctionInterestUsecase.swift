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
    return try await fetcher.fetchNextInterestAuctions()
  }
  
  public func loadInterestAuctionList(ids: [Int]) async throws -> [InterestWhether] {
    return try await fetcher.loadInterestAuctionList(ids: ids)
  }
}

actor AuctionInterestFetcher {
  private let repository: AuctionInterestRepositoriable
  private var cursor: String?
  private var hasNext: Bool = true
  private var isLoading: Bool = false
  private let loadOnce: Int = 20
  
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
  
  // 매물들의
  func removeUserInterestAuction(auctionID: Int) async throws {
    // TODO: - 유저정보 가지고오기
    try await repository.removeUserInterestAuction(auctionID: auctionID)
  }
  
  // 유저의 관심 탭 리스트
  func fetchUserInterestAuctions() async throws -> [InterestItem] {
    self.isLoading = true
    defer {
      self.isLoading = false
    }
    
    let interestSales = try await repository.fetchUserInterestAuctions(
      type: "product",
      cursor: cursor
    )
    
    if let nextCursor = interestSales.nextCursor,
       let _ = Int(nextCursor) {
      self.cursor = nextCursor
    } else {
      self.hasNext = false
    }
    return interestSales.items
  }
  
  func fetchNextInterestAuctions(type: String? = "product", cursor: String? = "unknown", size: Int = 20) async throws -> [InterestItem] {
    guard !isLoading else { return [] }
    guard hasNext else { return [] } // 더 이상 데이터 없음
    
    let fetchInterestList = try await fetchUserInterestAuctions()
    return fetchInterestList
  }
  
  // 주어진 매물들의 관심 설정여부 조회
  func loadInterestAuctionList(ids: [Int]) async throws -> [InterestWhether] {
    return try await repository.fetchInterestAuctionList(ids: ids)
  }
}
