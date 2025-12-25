//
//  AuctionHomeModelData.swift
//  Auction
//
//  Created by 송하민 on 5/4/25.
//

import Foundation
import SwiftUI
import SwiftData

import AppFoundation
import Domain

@Observable
final class AuctionHomeModelData {
  
  // MARK: - Internal Properties
  
  var auctionSalesItems: [AuctionSalesItem] = []
  var auctionSearchFilter: AuctionSearchFilter?
  
  var currentAuctionFilter: CurrentAuctionFilter = .init()
  
  var isLoading: Bool = false
  var isLoadingForPaging: Bool = false
  
  var totalAuctionCount: Int = .zero
  var currentSort: AuctionSortType = .recentRegistration
  var filteredItemCount: Int = .zero
  
  var error: MercuryError?
  
  // MARK: - Private Properties
  
  private let auctionListUsecase: AuctionSalesListUsecasable
  private let auctionSearchFilterUsecase: AuctionSearchFilterUsecasable
  
  // MARK: - Initialize
  
  init(
    auctionListUsecase: AuctionSalesListUsecasable,
    auctionSearchFilterUsecase: AuctionSearchFilterUsecasable
  ) {
    self.auctionListUsecase = auctionListUsecase
    self.auctionSearchFilterUsecase = auctionSearchFilterUsecase
    
    Task {
      do {
        try await fetchSearchFilters()
      } catch {
        self.error = error.toMercuryError()
      }
    }
  }
  
  // MARK: - Private Methods
  
  // MARK: - Internal Methods
  
  // 초기 경매물건 리스트 불러오기
  func loadAuctionSalesList() async {
    self.isLoading = true
    defer {
      self.isLoading = false
    }
    
    do {
      let auctionSales = try await auctionListUsecase.fetchAuctionSales(filter: self.currentAuctionFilter)
      if let auctionCount = auctionSales.auctionCount {
        self.totalAuctionCount = auctionCount
      }
      self.auctionSalesItems = auctionSales.items
      
    } catch {
      self.error = error.toMercuryError()
    }
  }
  
  // 경매물건 추가로 불러오기
  func loadMoreAuctionSales() async {
    withAnimation {
      self.isLoadingForPaging = true
    }
    defer {
      withAnimation {
        self.isLoadingForPaging = false
      }
    }
    let currentAuctionSalesItems = self.auctionSalesItems
    do {
      let auctionSalesItems = try await auctionListUsecase.fetchNextAuctionSales(filter: self.currentAuctionFilter)
      self.auctionSalesItems = currentAuctionSalesItems + auctionSalesItems
    } catch {
      self.error = error.toMercuryError()
    }
  }
  
  // 필터 가져오기
  func fetchSearchFilters() async throws {
    let filters = try await auctionSearchFilterUsecase.fetchAuctionSearchFilters()
    self.auctionSearchFilter = filters
  }
}
