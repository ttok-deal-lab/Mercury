//
//  AuctionBuildingUsageFilterView.swift
//  Auction
//
//  Created by 송하민 on 6/8/25.
//

import SwiftUI

import UIComponent

struct AuctionStatusFilterView: View {
  @State private var selectedChipTitles: Set<String> = []
  @Binding var modelData: AuctionHomeModelData
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
        selectedChipTitles: $selectedChipTitles,
        items: AuctionStatusType.allCases.map { ChipsType(title: $0.title) }
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
