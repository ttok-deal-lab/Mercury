//
//  AuctionBuildingUsageFilterView.swift
//  Auction
//
//  Created by 송하민 on 6/8/25.
//

import SwiftUI

import UIComponent

struct AuctionStatusFilterView: View {
  @Environment(AuctionHomeModelData.self) var modelData
  @State private var selectedChipTitles: Set<String> = []
  var onComplete: () -> Void
  
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
      
      ChipsContainerView(
        selectedChipIDs: $selectedChipTitles, items: []
      )
      MercuryButton("\(modelData.filteredItemCount)개 매물 보기") {
        onComplete()
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
    }
    .onChange(of: selectedChipTitles) { _, selectedChipTitles in
      let statusType = chipsToStatusType()
//      modelData.filterStatus(statusType: statusType)
    }
  }
  
  private func chipsToStatusType() -> [AuctionStatusType] {
    selectedChipTitles.compactMap { AuctionStatusType(rawValue: $0) }
  }
}
