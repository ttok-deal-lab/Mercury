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
  let auctionDetailInfo: AuctionDetail
  
  enum CardType { case emphasize, common }

  private let horizontalPadding: CGFloat = 20

  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text("한 눈에 보기")
        .fonts(.titleMediumBold)
        .foregroundStyle(Asset.Colors.neutral.color)

      HStack(spacing: 10) {
        briefCardView(type: .emphasize, title: "경매구분", content: auctionDetailInfo.displayCaseName)
        briefCardView(type: .common, title: "채권자", content: "\(auctionDetailInfo.creditorCount)명")
      }
    }
    .padding(.horizontal, horizontalPadding)
    .padding(.vertical, 24)
  }

  @ViewBuilder
  private func briefCardView(type: CardType, title: String, content: String) -> some View {
    let contentColor: Color = {
      switch type {
      case .emphasize: return Asset.Colors.criticalSubtle.color
      case .common: return Asset.Colors.neutral.color
      }
    }()

    let backgroundColor: Color = {
      switch type {
      case .emphasize: return Asset.Colors.criticalLight.color
      case .common: return Asset.Colors.neutralLight.color
      }
    }()

    VStack(spacing: 4) {
      Text(title)
        .fonts(.bodyMicroMedium)
        .foregroundStyle(Asset.Colors.neutralSubtler.color)

      Text(content)
        .fonts(.bodySmallBold)
        .foregroundStyle(contentColor)
    }
    .padding(.vertical, 12)
    .frame(maxWidth: .infinity)
    .background(backgroundColor, in: RoundedRectangle(cornerRadius: 12))
  }
}
