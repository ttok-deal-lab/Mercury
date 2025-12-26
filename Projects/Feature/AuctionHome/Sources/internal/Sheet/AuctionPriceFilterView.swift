//
//  AuctionPriceFilterView.swift
//  Auction
//
//  Created by 송하민 on 6/8/25.
//

import SwiftUI

import UIComponent

struct AuctionPriceFilterView: View {
  @Environment(AuctionHomeModelData.self) var modelData
  @State private var selectedChipTitles: Set<String> = []
  @State var lowestPrice: Double = .zero
  @State var highestPrice: Double = 20_000
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
      
      RangeSlider(
        lowerValue: $lowestPrice,
        upperValue: $highestPrice,
        range: 0...20000
      )
        .padding(.horizontal, 20)
      
      MercuryButton("\(modelData.filteredItemCount)개 매물 보기") {
        onComplete()
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
    }
    
  }
  
  private func chipsToStatusType() -> [AuctionStatusType] {
    selectedChipTitles.compactMap { AuctionStatusType(rawValue: $0) }
  }
}
