//
//  AbstractChipsView.swift
//  Auction
//
//  Created by 송하민 on 12/13/25.
//

import SwiftUI

import AppFoundation
import UIComponent
import Domain

/// 경매 물건 칩
struct AuctionDetailAbstractChipsView: View {
  let auctionDetailInfo: AuctionDetail
  
  private var saleStatusText: String {
    if auctionDetailInfo.soldOut {
      return "낙찰 완료"
    }
    
    // 목록/찜/최근본 화면의 salesLeftDays 와 동일한 계산을 사용해 D-day 표기를 일치시킨다
    let dDayOffset = auctionDetailInfo.salesDateTime.dDayOffset()

    switch dDayOffset {
    case 1...:
      return "매각 종료"
    case 0:
      return "오늘 매각"
    default:
      return "매각 D-\(abs(dDayOffset))"
    }
  }
  
  var body: some View {
    HStack(spacing: 4) {
      let bidTypeText = auctionDetailInfo.bidType.displayName
      if !bidTypeText.isEmpty {
        chipView(
          text: bidTypeText,
          foregroundColor: Asset.Colors.neutralSubtler.color,
          backgroundColor: Asset.Colors.neutralWeak.color
        )
      }

      chipView(
        text: L10n.commonFailedBidCount(auctionDetailInfo.failBidCount),
        foregroundColor: Asset.Colors.neutralSubtler.color,
        backgroundColor: Asset.Colors.neutralWeak.color
      )

      chipView(
        text: saleStatusText,
        foregroundColor: auctionDetailInfo.soldOut ? Asset.Colors.primary.color : Asset.Colors.critical.color,
        backgroundColor: auctionDetailInfo.soldOut ? Asset.Colors.primaryWeak.color : Asset.Colors.criticalWeak.color
      )

      Spacer()
    }
  }

  private func chipView(text: String, foregroundColor: Color, backgroundColor: Color) -> some View {
    Text(text)
      .fonts(.bodyMicroMedium)
      .foregroundStyle(foregroundColor)
      .padding(.horizontal, 6)
      .frame(height: 24)
      .background {
        backgroundColor
      }
      .clipShape(RoundedRectangle(cornerRadius: 8))
  }
}
