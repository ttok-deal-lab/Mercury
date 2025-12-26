//
//  SortDetailView.swift
//  Auction
//
//  Created by 송하민 on 5/5/25.
//

import SwiftUI

import UIComponent

struct AuctionSortHandlingView: View {
  @Environment(AuctionHomeModelData.self) var modelData
  var onSortSelected: () -> Void
  
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
      
      if let searchOptions = modelData.auctionSearchFilter?.searchOptions {
        ForEach(searchOptions, id: \.code) { type in
          Button {
            modelData.currentAuctionFilter.sort = type
            onSortSelected()
          } label: {
            HStack(spacing: .zero) {
              Text(type.displayName)
                .foregroundStyle(Asset.Colors.neutral.color)
                .fonts(.bodyLargeMedium)
              
              Spacer()
              if let currentSort = modelData.currentAuctionFilter.sort,
                 currentSort.code == type.code {
                Asset.Images.check.image
                  .resizable()
                  .frame(width: 20, height: 20)
              }
            }
            .padding(.horizontal, 20)
            .frame(height: 56)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
          }
        }
      }
    }
  }
}
