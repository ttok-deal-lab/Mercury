//
//  Untitled.swift
//  Domain
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

import AppFoundation

public final class AuctionSalesListUsecase: AuctionSalesListUsecasable {
  private let fetcher: AuctionSalesListFetcher
  
  public init(repository: AuctionSalesListRepositorable) {
    self.fetcher = AuctionSalesListFetcher(repository: repository)
  }
  
  public func fetchAuctionSales() async throws -> (auctionCount: Int?, items: [AuctionSalesItem]) {
    return try await self.fetcher.fetchInitial()
  }
  
  public func fetchNextAuctionSales() async throws -> [AuctionSalesItem] {
    return try await self.fetcher.fetchNext()
  }
  
}


actor AuctionSalesListFetcher {
  private let repository: AuctionSalesListRepositorable
  private let loadOnce: Int = 20
  private var cursor: String?
  private var hasNext: Bool = true
  private var isLoading: Bool = false
  
  init(repository: AuctionSalesListRepositorable) {
    self.repository = repository
  }
  
  func fetchInitial() async throws -> (auctionCount: Int?, items: [AuctionSalesItem]) {
    self.cursor = nil
    self.hasNext = true
    return try await fetch()
  }
  
  func fetchNext() async throws -> [AuctionSalesItem] {
    guard !isLoading else { return [] }
    guard hasNext else {
      return [] // 더 이상 데이터가 없음
    }
    let fetchResult = try await fetch()
    return fetchResult.items
  }
  
  private func fetch() async throws -> (auctionCount: Int?, items: [AuctionSalesItem]) {
    self.isLoading = true
    defer {
      self.isLoading = false
    }
    let fetchedAuctionSales = try await repository.fetchAuctionSales(
      cursor: cursor,
      size: loadOnce
    )
    
    self.cursor = fetchedAuctionSales.nextCursor
    self.hasNext = self.cursor != nil
    
    return (auctionCount: fetchedAuctionSales.searchHitCount, items: fetchedAuctionSales.items)
  }
}
