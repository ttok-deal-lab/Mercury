//
//  AuctionHomeNavigationView.swift
//  Auction
//
//  Created by 송하민 on 5/4/25.
//

import SwiftUI

import UIComponent
import Domain

struct AuctionHomeNavigationView: View {
  @Binding var applyingSearchFilter: CurrentAuctionFilter
  private let onSelectArea: () -> Void
  private let onTapSearch: () -> Void
  
  init(
    applyingSearchFilter: Binding<CurrentAuctionFilter>,
    onSelectArea: @escaping () -> Void,
    onTapSearch: @escaping () -> Void,
  ) {
    self._applyingSearchFilter = applyingSearchFilter
    self.onSelectArea = onSelectArea
    self.onTapSearch = onTapSearch
  }
  
  var searchingRegionText: String? {
    if let region = applyingSearchFilter.region {
      if let district = applyingSearchFilter.district {
        return region.displayName + " " + district.displayName
      } else {
        return region.displayName
      }
    }
    return nil
  }
  
  var body: some View {
    HStack(spacing: .zero) {
      Button {
        onSelectArea()
      } label: {
        HStack(spacing: 4) {
          if let searchingRegionText {
            Text(searchingRegionText)
              .fonts(.titleLargeBold)
              .foregroundStyle(Asset.Colors.neutral.color)
          } else {
            Text(L10n.homeDefaultArea)
              .fonts(.titleLargeBold)
              .foregroundStyle(Asset.Colors.neutral.color)
          }
          Asset.Images.arrowDownNoShaft.image
            .renderingMode(.template)
            .resizable()
            .foregroundStyle(Asset.Colors.neutral.color)
            .frame(width: 16, height: 16)
        }
      }
      Spacer()
      HStack(spacing: 16) {
        Button {
          onTapSearch() // TODO: 검색 화면 개발 필요
        } label: {
          Asset.Images.search.image
            .renderingMode(.template)
            .resizable()
            .foregroundStyle(Asset.Colors.neutral.color)
            .frame(width: 28, height: 28)
        }
      }
    }
    .padding(.horizontal, 20)
    .frame(height: 60)
  }
}
