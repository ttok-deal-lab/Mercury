//
//  FilterSalesTypeView.swift
//  Auction
//
//  Created by 송하민 on 6/8/25.
//

import SwiftUI

import UIComponent

struct FilterSalesTypeView: View {
  @State private var selectedChipTitles: Set<String> = []
  @Binding var modelData: AuctionHomeModelData
  var onComplete: () -> Void
  var selectedSalesTypes: [AuctionSalesType] = []
  
  var body: some View {
    VStack(spacing: .zero) {
      ChipsContainerView(
        selectedChipTitles: $selectedChipTitles,
        items: AuctionSalesType.allCases.map { ChipsType(title: $0.title) }
      )
      MercuryButton("\(modelData.filteredItemCount)개 매물 보기") {
        onComplete()
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
    }
    .onChange(of: selectedChipTitles) { _, selectedChipTitles in
      let salesType = chipsToSalesType()
      modelData.filterSales(salesType: salesType)
    }
  }
  
  private func chipsToSalesType() -> [AuctionSalesType] {
    selectedChipTitles.compactMap { AuctionSalesType(rawValue: $0) }
  }
}
