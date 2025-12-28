//
//  AuctionSortView.swift
//  Auction
//
//  Created by 송하민 on 5/4/25.
//

import SwiftUI

import AppFoundation
import UIComponent

struct SearchAuctionSortView: View {
  @Environment(SearchModelData.self) var modelData
  @State var isShowSortHandleView: Bool = false
  
  var body: some View {
    VStack(spacing: .zero) {
      HStack(spacing: .zero) {
        Text(L10n.auctionItem)
          .fonts(.bodyMicroMedium)
          .foregroundStyle(Asset.Colors.neutral.color)
        Text("\(modelData.filteredItemCount)")
          .fonts(.bodyMicroBold)
          .foregroundStyle(Asset.Colors.neutral.color)
        Spacer()
        
        if let sortOptions = modelData.currentAuctionFilter.sort {
          Button {
            isShowSortHandleView = true
          } label: {
            HStack(spacing: 2) {
              Text("\(sortOptions.displayName)")
                .foregroundStyle(Asset.Colors.neutral.color)
                .fonts(.bodyMiniMedium)
              Asset.Images.updown.image
                .resizable()
                .frame(width: 16, height: 16)
            }
          }
        }
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
      .sheet(isPresented: $isShowSortHandleView) {
        AuctionSortHandlingView(onSortSelected: {
          Task {
            await modelData.loadAuctionSalesList()
            isShowSortHandleView = false
          }
        })
        .dynamicSheet()
      }
    }
    
  }
}
