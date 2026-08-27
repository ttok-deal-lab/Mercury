//
//  AuctionFilterView.swift
//  Auction
//
//  Created by 송하민 on 5/4/25.
//

import SwiftUI

import AppFoundation
import UIComponent
import Domain

struct AuctionFilterView: View {
  @Environment(AuctionHomeModelData.self) private var modelData
  @State private var activeSheetItem: AuctionFilterType?
  
  var body: some View {
    ScrollView(.horizontal) {
      HStack(spacing: 6) {
        ForEach(AuctionFilterType.allCases) { type in
          AuctionFilterButton(
            type: type,
            isActive: modelData.isFilterActive(type),
            title: modelData.displayTitle(for: type)
          ) {
            handleTap(type)
          }
        }
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
    }
    .scrollIndicators(.hidden)
    .sheet(item: $activeSheetItem, onDismiss: {
      refreshData()
    }) { type in
      filterSheetContent(for: type)
        .dynamicSheet()
    }
  }
  
  // MARK: - Private Methods
  
  private func handleTap(_ type: AuctionFilterType) {
    if type.isSingleToggle {
      switch type {
      case .certified:
        modelData.currentAuctionFilter.isCertified.toggle()
      case .bidWon:
        modelData.currentAuctionFilter.soldOutStatus.selectNext()
      default:
        return
      }
      refreshData()
    } else {
      activeSheetItem = type
    }
  }
  
  private func refreshData() {
    Task {
      await modelData.loadAuctionSalesList(withFilter: true)
    }
  }
  
  // MARK: - ViewBuilders
  
  @ViewBuilder
  private func filterSheetContent(for type: AuctionFilterType) -> some View {
    switch type {
    case .buildingUsage:
      AuctionBuildingUsageFilterView {
        self.activeSheetItem = nil
      }
    case .auctionStatus:
      AuctionStatusFilterView {
        self.activeSheetItem = nil
      }
    case .price:
      AuctionPriceFilterView(
        lowerPrice: Double(modelData.currentAuctionFilter.minimumPrice ?? 0),
        upperPrice: Double(modelData.currentAuctionFilter.maximumPrice ?? 2_000_000_000)
      ) {
        self.activeSheetItem = nil
      }
    default:
      EmptyView()
    }
  }
}
