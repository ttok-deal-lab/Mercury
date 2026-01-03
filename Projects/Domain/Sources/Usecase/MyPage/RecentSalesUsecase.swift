//
//  RecentViewListUsecase.swift
//  Domain
//
//  Created by 최수훈 on 12/29/25.
//

import Foundation

import AppFoundation

public class RecentSalesUsecase: RecentSalesUsecasable {
  private let fetcher : RecentViewListFetcher
  
  public init(
    repository: RecentSalesRepositoriable,
    localStorageUseCase: LocalStorageUsecasable
  ) {
    self.fetcher = RecentViewListFetcher(
      repostiory: repository,
      localStorageUseCase: localStorageUseCase
    )
  }
  public func fetchRecentViewList() async throws -> [RecentSalesItem] {
    return try await self.fetcher.fetchRecentViewList()
  }
}


actor RecentViewListFetcher {
  private let localStorageUseCase: LocalStorageUsecasable
  private let repostiory: RecentSalesRepositoriable
  private var isLoading: Bool = false
  
  init(
    repostiory: RecentSalesRepositoriable,
    localStorageUseCase: LocalStorageUsecasable
  ) {
    self.repostiory = repostiory
    self.localStorageUseCase = localStorageUseCase
  }
  
  func fetchRecentViewList() async throws -> [RecentSalesItem] {
    self.isLoading = true
    defer {
      self.isLoading = false
    }
    
    guard let recentSalesInfo = await localStorageUseCase.getModel(
      forKey: LocalStorageKey.recentViwedSales.rawValue,
      as: [RecentSalesInfo].self
    ) else {
      return []
    }
    
    var recentSalesList = try await repostiory.fetchRecentViewList(auctionIDs: recentSalesInfo)
    for info in recentSalesInfo {
      let id = info.id
      if let index = recentSalesList.firstIndex(where: { $0.id == id }) {
        let sales = recentSalesList[index]
        recentSalesList.remove(at: index)
        recentSalesList.append(sales)
      }
    }
    return recentSalesList
  }
}
