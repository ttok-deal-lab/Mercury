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
  private var modelContext: ModelContext
  // MARK: - internal properties
  var auctionSalesItems: [AuctionSalesItem] = []
  var auctionSearchFilter: AuctionSearchFilter?
  
  private(set) var applyingAuctionSearchFilter: ApplyingAuctionSearchFilter = .init() {
    didSet {
      print("current filter: \(self.applyingAuctionSearchFilter)")
    }
  }
  
  var isLoading: Bool = false
  var isLoadingForPaging: Bool = false
  
  var totalAuctionCount: Int = .zero
  var currentSort: AuctionSortType = .recentRegistration
  var filteredItemCount: Int = .zero
  
  // MARK: - private properties
  
  private let auctionListUsecase: AuctionSalesListUsecasable
  private let auctionSearchFilterUsecase: AuctionSearchFilterUsecasable
  
  
  // MARK: - life cycle
  
  init(
    auctionListUsecase: AuctionSalesListUsecasable,
    auctionSearchFilterUsecase: AuctionSearchFilterUsecasable,
    modelContext: ModelContext
  ) {
    self.auctionListUsecase = auctionListUsecase
    self.auctionSearchFilterUsecase = auctionSearchFilterUsecase
    self.modelContext = modelContext
    
    Task {
      do {
        try await fetchSearchFilters()
      } catch {
        print("fetch filters err ~> \(error)")
      }
    }
    self.modelContext = modelContext
  }
  
  // MARK: - private methods
  
  // MARK: - internal methods

  // 초기 경매물건 리스트 불러오기
  func loadAuctionSalesList() async throws {
    self.isLoading = true
    defer {
      self.isLoading = false
    }
    
    do {
      let auctionSales = try await auctionListUsecase.fetchAuctionSales(filter: self.applyingAuctionSearchFilter)
      if let auctionCount = auctionSales.auctionCount {
        self.totalAuctionCount = auctionCount
      }
      self.auctionSalesItems = auctionSales.items
      
    } catch {
      throw error
    }
  }
  
  // 경매물건 추가로 불러오기
  func loadMoreAuctionSales() async throws {
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
      let auctionSalesItems = try await auctionListUsecase.fetchNextAuctionSales(filter: self.applyingAuctionSearchFilter)
      self.auctionSalesItems = currentAuctionSalesItems + auctionSalesItems
    } catch {
      throw error
    }
  }
  
  // 필터 가져오기
   func fetchSearchFilters() async throws {
     let filters = try await auctionSearchFilterUsecase.fetchAuctionSearchFilters()
     self.auctionSearchFilter = filters
   }
   
   // 필터링: 상위지역
   func filterRegion(region: Region) {
     Task {
       self.applyingAuctionSearchFilter.regionCode = region.code
       self.applyingAuctionSearchFilter.districtCode = nil
       
       try await loadAuctionSalesList()
     }
   }
   
   // 필터링: 하위지역
   func filterDistrict(district: District) {
     Task {
       self.applyingAuctionSearchFilter.districtCode = district.code
       
       try await loadAuctionSalesList()
     }
   }
  
}
