//
//  AuctionHomeNavigationView.swift
//  Auction
//
//  Created by 송하민 on 5/4/25.
//

import SwiftUI

import UIComponent

struct AuctionHomeNavigationView: View {
  @State private var currentArea: String = L10n.homeDefaultArea
  private let onSelectArea: (String) -> Void
  private let onTapSearch: () -> Void
  private let onTapNotification: () -> Void
  
  init(
    onSelectArea: @escaping (_ areaName: String) -> Void,
    onTapSearch: @escaping () -> Void,
    onTapNotification: @escaping () -> Void
  ) {
    self.onSelectArea = onSelectArea
    self.onTapSearch = onTapSearch
    self.onTapNotification = onTapNotification
  }
  
  var body: some View {
    HStack(spacing: .zero) {
      Button {
        onSelectArea("\(currentArea)") // TODO: 필터 개발 필요
      } label: {
        HStack(spacing: 4) {
          Text("\(currentArea)") // TODO: 필터 개발 필요
            .fonts(.titleLargeBold)
            .foregroundStyle(Asset.Colors.neutral.color)
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
        
        Button {
          onTapNotification() // TODO: 알림 화면 개발 필요
        } label: {
          Asset.Images.notification.image
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
