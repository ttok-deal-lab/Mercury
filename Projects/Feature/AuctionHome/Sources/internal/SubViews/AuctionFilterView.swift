//
//  AuctionFilterView.swift
//  Auction
//
//  Created by 송하민 on 5/4/25.
//

import SwiftUI

import AppFoundation
import UIComponent

fileprivate enum SheetType: String, Identifiable {
  var id: Self { self }
  
  case buildingUsage
  case auctionStatus
  case price
}

struct AuctionFilterView: View {
  @Environment(AuctionHomeModelData.self) private var modelData
  @State private var filterItems: [FilterItem] = AuctionFilterType.allCases.map { FilterItem(type: $0) }
  @State private var sheetType: SheetType?
  
  var body: some View {
    ScrollView(.horizontal) {
      HStack(spacing: 6) {
        ForEach($filterItems) { $item in
          Button {
            tapFilter(item: &item)
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
    .sheet(item: $sheetType) { type in
      switch type {
      case .buildingUsage:
        AuctionBuildingUsageFilterView() {
          self.sheetType = nil
          if let index = self.filterItems.firstIndex(where: { $0.type == .buildingUsage }) {
            self.setFilterItem(item: &self.filterItems[index])
          }
        }
        .dynamicSheet()
      case .auctionStatus:
        AuctionStatusFilterView() {
          self.sheetType = nil
          if let index = self.filterItems.firstIndex(where: { $0.type == .auctionStatus }) {
            self.setFilterItem(item: &self.filterItems[index])
          }
        }
        .dynamicSheet()
      case .price:
        AuctionPriceFilterView(
          lowerPrice: Double(modelData.currentAuctionFilter.minimumPrice ?? .zero),
          upperPrice: Double(modelData.currentAuctionFilter.maximumPrice ?? 2_000_000_000)
        ) {
          self.sheetType = nil
          if let index = self.filterItems.firstIndex(where: { $0.type == .price }) {
            self.setFilterItem(item: &self.filterItems[index])
          }
        }
        .dynamicSheet()
      }
    }
  }
  
  private func tapFilter(item: inout FilterItem) {
    if item.type.isSingleToggle {
      item.selectedValues = item.isActive ? [] : [item.type.defaultTitle]
    }
    switch item.type {
    case .buildingUsage:
      self.sheetType = .buildingUsage
    case .auctionStatus:
      self.sheetType = .auctionStatus
    case .price:
      self.sheetType = .price
    default:
      break
    }
  }
  
  private func setFilterItem(item: inout FilterItem) {
    guard !item.type.isSingleToggle else { return }
    switch item.type {
    case .buildingUsage:
      let buildingTypeOptions = modelData.auctionSearchFilter?.buildingTypes ?? []
      let selectedCodes: Set<String> = modelData.currentAuctionFilter.buildingTypeCodes ?? []
      let selectedBuildings: [String] = buildingTypeOptions
        .filter { option in selectedCodes.contains(option.code) }
        .map { $0.displayName }
      item.selectedValues = selectedBuildings
    case .auctionStatus:
      let statusOptions = modelData.auctionSearchFilter?.auctionFailOptions ?? []
      let selectedCodes: Set<String> = modelData.currentAuctionFilter.auctionFailCodes ?? []
      let selectedStatuses: [String] = statusOptions
        .filter { option in selectedCodes.contains(option.code) }
        .map { $0.displayName }
      item.selectedValues = selectedStatuses
    case .price:
      let filterText: String = {
        var returnValue: String = ""
        var minPrice: Int? {
          if let minPriceOrigin = modelData.currentAuctionFilter.minimumPrice, minPriceOrigin != .zero {
            return minPriceOrigin
          } else {
            return nil
          }
        }
        var maxPrice: Int? {
          if let maxPriceOrigin = modelData.currentAuctionFilter.maximumPrice, maxPriceOrigin != .zero {
            return maxPriceOrigin
          } else {
            return nil
          }
        }
        if let minPrice, let maxPrice {
          returnValue = minPrice.toKoreanFullWon+" 이상"+" "+maxPrice.toKoreanFullWon+" 이하"
        } else if let minPrice {
          returnValue = minPrice.toKoreanFullWon+" 이상"
        } else if let maxPrice {
          returnValue = maxPrice.toKoreanFullWon+" 이하"
        }
        return returnValue
      }()
      item.exclusiveValue = filterText
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

