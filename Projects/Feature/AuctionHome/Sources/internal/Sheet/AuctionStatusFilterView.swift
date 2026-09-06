//
//  AuctionBuildingUsageFilterView.swift
//  Auction
//
//  Created by 송하민 on 6/8/25.
//

import SwiftUI

import AppFoundation
import UIComponent

struct AuctionStatusFilterView: View {
  @Environment(AuctionHomeModelData.self) var modelData
  var onClosed: () -> Void
  
  @State private var reloadTask: Task<Void, Never>?
  
  var selectedAuctionStatusCodes: Binding<Set<String>> {
    Binding(
      get: { modelData.currentAuctionFilter.auctionFailCodes ?? []},
      set: { newValue in
        modelData.currentAuctionFilter.auctionFailCodes = newValue
        reloadTask?.cancel()
        reloadTask = Task {
          try? await Task.sleep(nanoseconds: 500_000_000) // 0.5초
          guard !Task.isCancelled else { return }
          await modelData.loadAuctionSalesList()
        }
      }
    )
  }
  
  var body: some View {
    VStack(spacing: .zero) {
      HStack {
        Text("경매상태")
          .foregroundStyle(Asset.Colors.neutral.color)
          .fonts(.titleLargeBold)
        Spacer()
      }
      .padding(.vertical, 16)
      .padding(.horizontal, 20)
      
      if let auctionStatusTypes = modelData.auctionSearchFilter?.auctionFailOptions {
        ChipsContainerView(
          selectedChipIDs: selectedAuctionStatusCodes,
          items: auctionStatusTypes.map { ChipsType(id: $0.code, title: $0.displayName)}
        )
      }
      
      MercuryButton("\(modelData.filteredItemCount.toCappedCountText)개 매물 보기") {
        onClosed()
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
    }
  }
}
