//
//  RecentSalesModelData.swift
//  MyPage
//
//  Created by 최수훈 on 12/26/25.
//

import SwiftUI
import Combine

import Domain

@Observable
final class RecentSalesModelData {
  // MARK: - internal property
  var recentViewList: [RecentSalesItem] = []
  var isLoading: Bool = false
  
  // MARK: - private property
  private let recentViewListUsecase: RecentSalesUsecasable
  // MARK: - life cycle
  
  init(recentViewListUsecase: RecentSalesUsecasable) {
    self.recentViewListUsecase = recentViewListUsecase
  }
  
  func loadRecentViewList() async throws {
    self.isLoading = true
    defer {
      self.isLoading = false
    }
    let recentList = try await recentViewListUsecase.fetchRecentViewList()
    
    recentViewList = recentList
  }
}
