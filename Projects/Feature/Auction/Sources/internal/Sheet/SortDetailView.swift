//
//  SortDetailView.swift
//  Auction
//
//  Created by 송하민 on 5/5/25.
//

import SwiftUI

import UIComponent

struct AuctionSortHandlingView: View {
  var body: some View {
    VStack(spacing: .zero) {
      HStack(spacing: .zero) {
        Text("정렬")
          .foregroundStyle(Asset.Colors.neutral.color)
          .fonts(.titleLargeBold)
        Spacer()
      }
      .padding(.vertical, 16)
      .padding(.horizontal, 20)
      
      ForEach(AuctionSortType.allCases) { type in
        HStack(spacing: .zero) {
          Text(type.displayName)
            .foregroundStyle(Asset.Colors.neutral.color)
            .fonts(.bodyLargeMedium)
            
          Spacer()
        }
        .padding(.horizontal, 20)
        .frame(height: 56)
      }
    }
  }
}
