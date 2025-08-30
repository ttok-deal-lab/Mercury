//
//  AuctionFilterView.swift
//  Auction
//
//  Created by 송하민 on 5/4/25.
//

import SwiftUI

import AppFoundation
import UIComponent

struct AuctionFilterView: View {
  @Binding var modelData: AuctionHomeModelData
  @State private var isBuildingUsageFilterSheetShow: Bool = false
  @State private var isAuctionStatusFilterSheetShow: Bool = false
  @State private var isPriceFilterSheetShow: Bool = false
  @State private var filterItems: [FilterItem] = AuctionFilterType.allCases.map { FilterItem(type: $0) }
  
  var body: some View {
    ScrollView(.horizontal) {
      HStack(spacing: 6) {
        ForEach($filterItems) { $item in
          Button {
            toggle(item: &item)
          } label: {
            HStack(spacing: 4) {
              if let image = item.type.leftImage {
                image
                  .resizable()
                  .frame(width: 16, height: 16)
              }
              
              Text(item.displayTitle)
                .fonts(.bodyMiniMedium)
                .foregroundStyle(item.isActive ? Asset.Colors.neutralWhite.color : Asset.Colors.neutral.color)
              
              if item.isExpandable {
                Asset.Images.arrowDownNoShaft.image
                  .renderingMode(.template)
                  .resizable()
                  .foregroundStyle(item.isActive ? Asset.Colors.neutralWhite.color : Asset.Colors.neutral.color)
                  .frame(width: 16, height: 16)
              }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .overlay {
              Capsule()
                .stroke(style: .init(lineWidth: 1))
                .foregroundStyle(item.isActive ? .clear : Asset.Colors.gray150.color)
            }
            .background(item.isActive ? Asset.Colors.neutral.color : .clear)
            .clipShape(Capsule())
          }
        }
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
    }
    .scrollIndicators(.hidden)
    .sheet(isPresented: $isBuildingUsageFilterSheetShow) {
      AuctionBuildingUsageFilterView(modelData: $modelData) {
        isBuildingUsageFilterSheetShow = false
      }
      .dynamicSheet()
    }
    .sheet(isPresented: $isAuctionStatusFilterSheetShow) {
      AuctionStatusFilterView(modelData: $modelData) {
        isAuctionStatusFilterSheetShow = false
      }
      .dynamicSheet()
    }
    .sheet(isPresented: $isPriceFilterSheetShow) {
      AuctionPriceFilterView(modelData: $modelData) {
        isPriceFilterSheetShow = false
      }
      .dynamicSheet()
    }
  }
  
  private func toggle(item: inout FilterItem) {
    if item.type.isSingleToggle {
      item.selectedValues = item.isActive ? [] : [item.type.defaultTitle]
    }
    switch item.type {
    case .buildingUsage:
      isBuildingUsageFilterSheetShow = true
    case .auctionStatus:
      isAuctionStatusFilterSheetShow = true
    case .price:
      isPriceFilterSheetShow = true
    default:
      break
    }
  }
}

extension AuctionFilterType {
  var leftImage: Image? {
    return self == .certified ? Asset.Images.certified.image : nil
  }
}
