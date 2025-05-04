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

enum AuctionSortType {
  case recentUpload(isAsc: Bool)
}

@Observable
final class AuctionHomeModelData {
  var items: [AuctionItem] = []
  var isLoading: Bool = false
  var totalAuctionCount: Int = .zero
  var currentSort: AuctionSortType = .recentUpload(isAsc: false) {
    didSet {
      Task { [weak self] in
        guard let self else { return }
        self.sort(with: self.currentSort)
      }
    }
  }
  
  private let auctionListUsecase: AuctionListUsecasable
  
  init(auctionListUsecase: AuctionListUsecasable) {
    self.auctionListUsecase = auctionListUsecase
  }
  
  private func sort(with type: AuctionSortType) {
    Task { [weak self] in
      await MainActor.run { [weak self] in
        self?.isLoading = true
      }
      switch type {
      case .recentUpload(let isAsc):
        var sortedItems: [AuctionItem] {
          let items = self?.items.sorted { lhs, rhs in
            isAsc ? lhs.createdAt >= rhs.createdAt : lhs.createdAt <= rhs.createdAt
          }
          return items ?? []
        }
        await MainActor.run { [weak self] in
          self?.items = sortedItems
          self?.isLoading = false
        }
      }
    }
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
