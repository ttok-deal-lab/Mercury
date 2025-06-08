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

enum AuctionSortType: String, Identifiable, CaseIterable {
  var id: String {
    self.rawValue
  }
  
  /// 최신 등록순
  case recentRegistration
  /// 관심 많은 순
  case mostInterested
  /// 기일 임박 순
  case impendingDueDate
  /// 유찰 적은 순
  case lessBidding
  /// 가격 높은 순
  case highPrice
  /// 가격 낮은 순
  case lowPrice
}

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
  
  func loadAuctionList() async throws {
    await MainActor.run { [weak self] in
      self?.isLoading = true
    }
    
    do {
      let items = try await auctionListUsecase.fetchAllList(courtName: "서울중앙지방법원")
      
      await MainActor.run { [weak self] in
        self?.totalAuctionCount = items.count
        self?.items = items
        self?.isLoading = false
        print("first item ~> \n\(items.first)")
      }
    } catch {
      await MainActor.run { [weak self] in
        self?.isLoading = false
      }
      throw error
    }
  }
  
}
