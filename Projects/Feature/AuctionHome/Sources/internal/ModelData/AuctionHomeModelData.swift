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
@MainActor
final class AuctionHomeModelData {
  private var modelContext: ModelContext
  // MARK: - internal properties
  var auctionSalesItems: [AuctionSalesItem] = []
  var isLoading: Bool = false
  var isLoadingForPaging: Bool = false
  var totalAuctionCount: Int = .zero
  var currentSort: AuctionSortType = .recentRegistration {
    didSet {
      Task { [weak self] in
        self?.sort(with: self?.currentSort ?? .recentRegistration)
      }
    }
  }
  var filteredItemCount: Int = .zero
  
  // MARK: - private properties
  
  private let auctionListUsecase: AuctionSalesListUsecasable
  
  // MARK: - life cycle
  
  init(
    auctionListUsecase: AuctionSalesListUsecasable,
    modelContext: ModelContext
  ) {
    self.auctionListUsecase = auctionListUsecase
    self.modelContext = modelContext
  }
  
  // MARK: - private methods
  
  private func sort(with type: AuctionSortType) {
    self.isLoading = true
    var sortedItems: [AuctionSalesItem] = self.auctionSalesItems
    sortedItems = self.auctionSalesItems.sorted(by: { lhsItem, rhsItem in
      switch type {
      case .recentRegistration:
        return lhsItem.salesDateTime >= rhsItem.salesDateTime
      case .mostInterested:
        return lhsItem.zzimCount >= rhsItem.zzimCount
      case .impendingDueDate:
        return false // TODO: 백엔드 개발필요
      case .lessBidding:
        return lhsItem.failBidCount <= rhsItem.failBidCount
      case .highPrice:
        return lhsItem.appraisalPrice >= rhsItem.appraisalPrice
      case .lowPrice:
        return lhsItem.appraisalPrice <= rhsItem.appraisalPrice
      }
    })
    self.auctionSalesItems = sortedItems
    self.isLoading = false
  }
  
  // MARK: - internal methods
  
  func filterBuildingUsage(usageType: [AuctionBuildingUsageType]) {
    self.isLoading = true
    defer {
      self.isLoading = false
    }
    
    var filteredItem: [AuctionSalesItem] = self.auctionSalesItems
    filteredItem = self.auctionSalesItems.filter { item in
      return true // TODO: 백엔드 작업 후 진행
    }
    self.auctionSalesItems = filteredItem
  }
  
  func filterStatus(statusType: [AuctionStatusType]) {
    self.isLoading = true
    defer {
      self.isLoading = false
    }
    
    var filteredItem: [AuctionSalesItem] = self.auctionSalesItems
    filteredItem = self.auctionSalesItems.filter { item in
      return true // TODO: 백엔드 작업 후 진행
    }
    self.auctionSalesItems = filteredItem
  }
  
  func loadAuctionSalesList() async throws {
    self.isLoading = true
    defer {
      self.isLoading = false
    }
    
    do {
      let auctionSales = try await auctionListUsecase.fetchAuctionSales()
      if let auctionCount = auctionSales.auctionCount {
        self.totalAuctionCount = auctionCount
      }
      self.auctionSalesItems = auctionSales.items
      
    } catch {
      throw error
    }
  }
  
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
      let auctionSalesItems = try await auctionListUsecase.fetchNextAuctionSales()
      self.auctionSalesItems = currentAuctionSalesItems + auctionSalesItems
    } catch {
      throw error
    }
  }
  
  func saveRecentItem(_ item: AuctionSalesItem) {
    // entity to SD Model
    let recentItem = SDAuctionItem(
      salesId: item.id,
      caseNumber: item.caseNumber,
      salesAddress: item.salesAddress,
      salesCategories: item.salesCategories,
      salesDateTime: item.salesDateTime,
      appraisalPrice: item.appraisalPrice,
      failBidCount: item.failBidCount,
      zzimCount: item.zzimCount,
      registerDate: item.registerDate,
      verified: item.verified,
      isSoldOut: item.isSoldOut,
      createdAt: Date.now
    )
    
    // 중복 제거
    let id = item.id
    try? modelContext.delete(model: SDAuctionItem.self, where: #Predicate { $0.salesId == id})
    
    modelContext.insert(recentItem)
    try? modelContext.save()
  }
}
