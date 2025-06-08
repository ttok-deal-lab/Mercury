//
//  AuctionSortView.swift
//  Auction
//
//  Created by 송하민 on 5/4/25.
//

import SwiftUI

import AppFoundation
import UIComponent

struct AuctionSortView: View {
  @Binding var modelData: AuctionHomeModelData
  @State var isShowSortHandleView: Bool = false
  
  var body: some View {
    VStack(spacing: .zero) {
      HStack(spacing: .zero) {
        Text(L10n.auctionItem)
          .fonts(.bodyMicroMedium)
          .foregroundStyle(Asset.Colors.neutral.color)
        Text("\(modelData.totalAuctionCount)")
          .fonts(.bodyMicroBold)
          .foregroundStyle(Asset.Colors.neutral.color)
        Spacer()
        
        Button {
          isShowSortHandleView = true
        } label: {
          HStack(spacing: 2) {
            Text("\(modelData.currentSort.displayName)")
              .foregroundStyle(Asset.Colors.neutral.color)
              .fonts(.bodyMiniMedium)
            Asset.Images.updown.image
              .resizable()
              .frame(width: 16, height: 16)
          }
        }
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .sheet(isPresented: $isShowSortHandleView) {
        AuctionSortHandlingView()
          .dynamicSheet()
      }
    }
    
  }
}

extension AuctionSortType {
  var displayName: String {
    switch self {
    case .recentRegistration:
      L10n.auctionSortByLatestRegistration
    case .mostInterested:
      L10n.auctionSortByMostInterested
    case .impendingDueDate:
      L10n.auctionSortByImpendingDueDate
    case .lessBidding:
      L10n.auctionSortByLessBidding
    case .highPrice:
      L10n.auctionSortByPriceHigher
    case .lowPrice:
      L10n.auctionSortByPriceLower
    }
  }
}
