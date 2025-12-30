//
//  AuctionPriceFilterView.swift
//  Auction
//
//  Created by 송하민 on 6/8/25.
//

import SwiftUI

import UIComponent

struct AuctionPriceFilterView: View {
  @Environment(SearchModelData.self) var modelData
  @State private var priceRange: ClosedRange<Double>
  @State private var isFirstEnter = true
  
  init(lowerPrice: Double, upperPrice: Double, onComplete: @escaping () -> Void) {
    self._priceRange = State(initialValue: lowerPrice...upperPrice)
    self.onComplete = onComplete
  }
  
  var onComplete: () -> Void
  
  var body: some View {
    VStack(spacing: .zero) {
      HStack {
        Text("가격")
          .foregroundStyle(Asset.Colors.neutral.color)
          .fonts(.titleLargeBold)
        Spacer()
      }
      .padding(.vertical, 16)
      .padding(.horizontal, 20)
      
      PriceRangeSlider(
        range: $priceRange,
        bounds: 0...2_000_000_000
      )
      
      MercuryButton("\(modelData.filteredItemCount)개 매물 보기") {
        onComplete()
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
    }
    .task(id: priceRange) {
      do {
        if isFirstEnter {
          isFirstEnter = false
          return
        }
        modelData.currentAuctionFilter.minimumPrice = Int(priceRange.lowerBound)
        modelData.currentAuctionFilter.maximumPrice = Int(priceRange.upperBound)
        try await Task.sleep(nanoseconds: 500_000_000)
        await modelData.loadAuctionSalesList()
      } catch { }
    }
    
  }
}
