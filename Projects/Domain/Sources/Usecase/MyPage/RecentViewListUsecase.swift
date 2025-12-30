//
//  RecentViewListUsecase.swift
//  Domain
//
//  Created by 최수훈 on 12/29/25.
//

import Foundation

public class RecentViewListUsecase: RecentViewListUsecasable {
  private let fetcher : RecentViewListFetcher
  
  public init(
    repository: RecentViewListRepositoriable,
    localStorageUseCase: LocalStorageUsecasable
  ) {
    self.fetcher = RecentViewListFetcher(
      repostiory: repository,
      localStorageUseCase: localStorageUseCase
    )
  }
  public func fetchRecentViewList() async throws -> [RecentViewSalesItem] {
    return try await self.fetcher.fetchRecentViewList()
  }
}


actor RecentViewListFetcher {
  private let localStorageUseCase: LocalStorageUsecasable
  private let repostiory: RecentViewListRepositoriable
  private var isLoading: Bool = false
  
  init(
    repostiory: RecentViewListRepositoriable,
    localStorageUseCase: LocalStorageUsecasable
  ) {
    self.repostiory = repostiory
    self.localStorageUseCase = localStorageUseCase
  }
  
  func fetchRecentViewList() async throws -> [RecentViewSalesItem] {
    self.isLoading = true
    defer {
      self.isLoading = false
    }
    
    guard let recentSalesInfo = await localStorageUseCase.getModel(
      forKey: .recentViwedSales,
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
