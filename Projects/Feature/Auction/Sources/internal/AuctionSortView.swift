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
  
  var body: some View {
    VStack(spacing: .zero) {
      HStack(spacing: .zero) {
        Text("상품 ")
          .fonts(.bodyMicroMedium)
          .foregroundStyle(Asset.Colors.gray700TextDefault.color)
        Text("\(modelData.totalAuctionCount)")
          .fonts(.bodyMicroBold)
          .foregroundStyle(Asset.Colors.gray700TextDefault.color)
        Spacer()
        
        Button {
          switch modelData.currentSort {
          case .recentUpload(let isAsc):
            self.modelData.currentSort = .recentUpload(isAsc: !isAsc)
          }
        } label: {
          HStack(spacing: 2) {
            Text("\(modelData.currentSort.displayName)")
              .foregroundStyle(Asset.Colors.gray700TextDefault.color)
              .fonts(.bodyMiniMedium)
            Asset.Images.updown.image
              .resizable()
              .frame(width: 16, height: 16)
          }
        }

      }
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
    }
    
  }
}

extension AuctionSortType {
  var displayName: String {
    switch self {
    case .recentUpload:
      "최신 등록순"
    }
  }
}
