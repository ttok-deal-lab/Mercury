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
  
  public func isAuctionInterested(auctionID: Int) async throws -> Bool {
    return try await fetcher.isAuctionUserInterested(auctionID: auctionID)
  }
  
  public func addInterest(auctionID: Int) async throws {
    try await fetcher.addUserInterestAuction(auctionID: auctionID)
  }
  
  public func removeInterest(auctionID: Int) async throws {
    try await fetcher.removeUserInterestAuction(auctionID: auctionID)
  }
  
  public func resetPagination() async {
    await fetcher.resetPagination()
  }

  public func loadInterest() async throws -> [InterestItem] {
    return try await fetcher.fetchUserInterestAuctions()
  }
  
  public func loadNextInterest() async throws -> [InterestItem] {
    return try await fetcher.fetchNextInterestAuctions()
  }
  
  public func loadInterestList(ids: [Int]) async throws -> [InterestWhether] {
    return try await fetcher.loadInterestAuctionList(ids: ids)
  }
}

actor AuctionInterestFetcher {
  private let repository: AuctionInterestRepositoriable
  private var cursor: String?
  private var hasNext: Bool = true
  private var isLoading: Bool = false
  private let loadOnce: Int = 20

  /// 최근 토글된 찜 상태만 보관 — 배치 조회 시 서버 응답이 낙관적 업데이트를 덮어쓰는 race condition 방지
  private var recentToggles: [Int: Bool] = [:]

  init(repository: AuctionInterestRepositoriable) {
    self.repository = repository
  }

  func isAuctionUserInterested(auctionID: Int) async throws -> Bool {
    if let toggled = recentToggles[auctionID] {
      return toggled
    }
    return try await repository.isAuctionInterested(auctionID: auctionID)
  }

  func addUserInterestAuction(auctionID: Int) async throws {
    try await repository.addInterest(auctionID: auctionID)
    recentToggles[auctionID] = true
  }

  func removeUserInterestAuction(auctionID: Int) async throws {
    try await repository.removeInterest(auctionID: auctionID)
    recentToggles[auctionID] = false
  }

  func resetPagination() {
    self.cursor = nil
    self.hasNext = true
    self.isLoading = false
  }

  func fetchUserInterestAuctions() async throws -> [InterestItem] {
    self.isLoading = true
    defer {
      self.isLoading = false
    }

    let interestSales = try await repository.fetchInterest(
      type: "product",
      cursor: cursor
    )

    if let nextCursor = interestSales.nextCursor {
      self.cursor = nextCursor
    } else {
      self.hasNext = false
    }
    return interestSales.items
  }

  func fetchNextInterestAuctions(type: String? = "product", cursor: String? = "unknown", size: Int = 20) async throws -> [InterestItem] {
    guard !isLoading else { return [] }
    guard hasNext else { return [] }

    let fetchInterestList = try await fetchUserInterestAuctions()
    return fetchInterestList
  }

  func loadInterestAuctionList(ids: [Int]) async throws -> [InterestWhether] {
    let serverResults = try await repository.fetchInterestList(ids: ids)
    return serverResults.map { item in
      if let toggled = recentToggles[item.id] {
        return InterestWhether(id: item.id, favorite: toggled)
      }
      return item
    }
  }
}
