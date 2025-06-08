//
//  SortDetailView.swift
//  Auction
//
//  Created by 송하민 on 5/5/25.
//

import SwiftUI

import UIComponent

struct AuctionSortHandlingView: View {
  @Binding var modelData: AuctionHomeModelData
  var onComplete: () -> Void
  
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
        Button {
          modelData.currentSort = type
          onComplete()
        } label: {
          HStack(spacing: .zero) {
            Text(type.displayName)
              .foregroundStyle(Asset.Colors.neutral.color)
              .fonts(.bodyLargeMedium)

            Spacer()
            if modelData.currentSort == type {
              Asset.Images.check.image
                .resizable()
                .frame(width: 20, height: 20)
            }
          }
          .padding(.horizontal, 20)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .contentShape(Rectangle())
        }
        .frame(height: 56)
        .buttonStyle(PressableBackgroundStyle(
          pressedColor: Asset.Colors.neutralLight.color
        ))
      }

    }
  }
}
