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
  var items: [AuctionItem] = []
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
  
  private let auctionListUsecase: AuctionListUsecasable
  
  init(auctionListUsecase: AuctionListUsecasable) {
    self.auctionListUsecase = auctionListUsecase
  }
  
  private func sort(with type: AuctionSortType) {
    self.isLoading = true
    var sortedItems: [AuctionItem] = self.items
    sortedItems = self.items.sorted { lhs, rhs in
      switch type {
      case .recentRegistration:
        return lhs.createdAt >= rhs.createdAt
      case .mostInterested:
        return false  // TODO: 백엔드 개발 필요
      case .impendingDueDate:
        return lhs.distributionRequiredDeadlineDate >= rhs.distributionRequiredDeadlineDate
      case .lessBidding:
        return false // TODO: 백엔드 개발 필요
      case .highPrice:
        return lhs.claimPrice >= rhs.claimPrice
      case .lowPrice:
        return lhs.claimPrice <= rhs.claimPrice
      }
    }
    self.items = sortedItems
    self.isLoading = false
  }
  
  func filterBuildingUsage(usageType: [AuctionBuildingUsageType]) {
    self.isLoading = true
    var filteredItem: [AuctionItem] = self.items
    filteredItem = self.items.filter { item in
      return true // TODO: 백엔드 작업 후 진행
    }
    self.items = filteredItem
    self.isLoading = false
  }
  
  func filterStatus(statusType: [AuctionStatusType]) {
    self.isLoading = true
    var filteredItem: [AuctionItem] = self.items
    filteredItem = self.items.filter { item in
      return true // TODO: 백엔드 작업 후 진행
    }
    self.items = filteredItem
    self.isLoading = false
  }
  
  func loadAuctionList() async throws {
    self.isLoading = true
    
    do {
      let items = try await auctionListUsecase.fetchAllList(courtName: "서울중앙지방법원")
      self.totalAuctionCount = items.count
      self.items = items
      self.filteredItemCount = items.count
      self.isLoading = false
    } catch {
      self.isLoading = false
      throw error
    }
  }
  
}
