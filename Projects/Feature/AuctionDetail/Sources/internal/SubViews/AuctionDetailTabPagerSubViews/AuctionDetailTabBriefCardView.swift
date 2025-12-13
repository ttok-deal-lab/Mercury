//
//  AuctionDetailTabBriefCardView.swift
//  AuctionDetail
//
//  Created by 송하민 on 12/13/25.
//

import SwiftUI

import UIComponent
import Domain

import SwiftUI
import UIComponent
import Domain

struct AuctionDetailTabBriefCardView: View {
  enum CardType { case emphasize, common }

  struct CardInfo: Identifiable {
    var id: String { title }
    let type: CardType
    let title: String
    let content: String
  }

  private let mockData: [CardInfo] = [
    .init(type: .emphasize, title: "경매구분", content: "강제경매"),
    .init(type: .emphasize, title: "임차인", content: "대항력 있음"),
    .init(type: .common, title: "채권자", content: "5명")
  ]

  private let horizontalPadding: CGFloat = 20

  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text("한 눈에 보기")
        .fonts(.titleMediumBold)
        .foregroundStyle(Asset.Colors.neutral.color)

      HStack(spacing: 10) {
        ForEach(mockData) { data in
          briefCardView(info: data)
            .frame(maxWidth: .infinity)
        }
      }
    }
    .padding(.horizontal, horizontalPadding)
    .padding(.vertical, 24)
  }

  @ViewBuilder
  private func briefCardView(info: CardInfo) -> some View {
    let contentColor: Color = {
      switch info.type {
      case .emphasize: return Asset.Colors.criticalSubtle.color
      case .common: return Asset.Colors.neutral.color
      }
    }()

    let backgroundColor: Color = {
      switch info.type {
      case .emphasize: return Asset.Colors.criticalLight.color
      case .common: return Asset.Colors.neutralLight.color
      }
    }()

    VStack(spacing: 4) {
      Text(info.title)
        .fonts(.bodyMicroMedium)
        .foregroundStyle(Asset.Colors.neutralSubtler.color)

      Text(info.content)
        .fonts(.bodySmallBold)
        .foregroundStyle(contentColor)
    }
    .padding(.vertical, 12)
    .frame(maxWidth: .infinity)
    .background(backgroundColor, in: RoundedRectangle(cornerRadius: 12))
  }
}
