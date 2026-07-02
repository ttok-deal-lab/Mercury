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
  
  public func fetchAuctionSales(filter: CurrentAuctionFilter?) async throws -> (auctionCount: Int?, items: [AuctionSalesItem]) {
    return try await self.fetcher.fetchInitial(filter: filter)
  }
  
  public func fetchNextAuctionSales(filter: CurrentAuctionFilter?) async throws -> [AuctionSalesItem] {
    return try await self.fetcher.fetchNext(filter: filter)
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
  
  func fetchInitial(filter: CurrentAuctionFilter?) async throws -> (auctionCount: Int?, items: [AuctionSalesItem]) {
    self.cursor = nil
    self.hasNext = true
    return try await fetch(filter: filter)
  }
  
  func fetchNext(filter: CurrentAuctionFilter?) async throws -> [AuctionSalesItem] {
    guard !isLoading else { return [] }
    guard hasNext else {
      return [] // 더 이상 데이터가 없음
    }
    let fetchResult = try await fetch(filter: filter)
    return fetchResult.items
  }
  
  private func fetch(filter: CurrentAuctionFilter?) async throws -> (auctionCount: Int?, items: [AuctionSalesItem]) {
    self.isLoading = true
    defer {
      self.isLoading = false
    }
    let fetchedAuctionSales = try await repository.fetchAuctionSales(
      filter: filter,
      cursor: cursor,
      size: loadOnce
    )
    
    if let nextCursor = fetchedAuctionSales.nextCursor {
      self.cursor = nextCursor
    } else {
      self.hasNext = false
    }
    
    return (auctionCount: fetchedAuctionSales.searchHitCount, items: fetchedAuctionSales.items)
  }
}
