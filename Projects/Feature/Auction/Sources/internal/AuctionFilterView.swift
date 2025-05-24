//
//  AuctionFilterView.swift
//  Auction
//
//  Created by 송하민 on 5/4/25.
//

import SwiftUI

import AppFoundation
import UIComponent

struct AuctionFilterView: View { // 기본 UI만 잡아놓음. 추가 개발 필요
  
  @State private var items: [FilterItem] = AuctionFilterType.allCases.map { FilterItem(type: $0) }
  
  var body: some View {
    ScrollView(.horizontal) {
      HStack(spacing: 6) {
        ForEach($items) { $item in
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
                .foregroundStyle(item.isActive ? Asset.Colors.gray10TextWhite.color : Asset.Colors.gray700TextDefault.color)
              
              if item.isExpandable {
                Asset.Images.arrowDownNoShaft.image
                  .renderingMode(.template)
                  .resizable()
                  .foregroundStyle(item.isActive ? Asset.Colors.gray10TextWhite.color : Asset.Colors.gray700TextDefault.color)
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
            .background(item.isActive ? Asset.Colors.gray700TextDefault.color : .clear)
            .clipShape(Capsule())
          }
        }
      }
      .padding(.horizontal, 20)
      .padding(.vertical, 12)
    }
    .scrollIndicators(.hidden)
  }
  
  private func toggle(item: inout FilterItem) {
    if item.type.isSingleToggle {
      item.selectedValues = item.isActive ? [] : [item.type.defaultTitle]
    } else {
      print("바텀시트 필요")
    }
  }
}

extension AuctionFilterType {
  var leftImage: Image? {
    return self == .certified ? Asset.Images.certified.image : nil
  }
}
