//
//  AuctionHomeModelData.swift
//  Auction
//
//  Created by 송하민 on 5/4/25.
//

import Foundation
import SwiftUI

import AppFoundation
import Domain

@Observable
final class AuctionHomeModelData {
  var auctionSalesItems: [AuctionSalesItem] = []
  var isLoading: Bool = false
  var totalAuctionCount: Int = .zero
  var currentSort: AuctionSortType = .recentRegistration {
    didSet {
      Task { [weak self] in
        self?.sort(with: self?.currentSort ?? .recentRegistration)
      }
    }
  }
  var filteredItemCount: Int = .zero
  
  private let auctionListUsecase: AuctionSalesListUsecasable
  
  init(auctionListUsecase: AuctionSalesListUsecasable) {
    self.auctionListUsecase = auctionListUsecase
  }
  
  private func sort(with type: AuctionSortType) {
    self.isLoading = true
    var sortedItems: [AuctionSalesItem] = self.auctionSalesItems
    sortedItems = self.auctionSalesItems.sorted(by: { lhsItem, rhsItem in
      switch type {
      case .recentRegistration:
        return lhsItem.salesDate >= rhsItem.salesDate
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
  
  func filterBuildingUsage(usageType: [AuctionBuildingUsageType]) {
    self.isLoading = true
    var filteredItem: [AuctionSalesItem] = self.auctionSalesItems
    filteredItem = self.auctionSalesItems.filter { item in
      return true // TODO: 백엔드 작업 후 진행
    }
    self.auctionSalesItems = filteredItem
    self.isLoading = false
  }
  
  func filterStatus(statusType: [AuctionStatusType]) {
    self.isLoading = true
    var filteredItem: [AuctionSalesItem] = self.auctionSalesItems
    filteredItem = self.auctionSalesItems.filter { item in
      return true // TODO: 백엔드 작업 후 진행
    }
    self.auctionSalesItems = filteredItem
    self.isLoading = false
  }
  
  func loadAuctionSalesList() async throws {
    self.isLoading = true
    
    do {
      let auctionSales = try await auctionListUsecase.fetchAllSalesList()
      
      self.totalAuctionCount = auctionSales.itmes.count
      self.filteredItemCount = auctionSales.itmes.count
      self.auctionSalesItems = auctionSales.itmes
      
      self.isLoading = false
    } catch {
      self.isLoading = false
      throw error
    }
  }
  
}
