//
//  AbstractChipsView.swift
//  Auction
//
//  Created by 송하민 on 12/13/25.
//

import SwiftUI

import UIComponent
import Domain

/// 경매 물건 칩
struct AuctionDetailAbstractChipsView: View {
  let auctionDetailInfo: AuctionDetail
  
  var body: some View {
    HStack(spacing: 4) {
      HStack(spacing: 4) {
        Asset.Images.certified.image
          .resizable()
          .renderingMode(.template)
          .foregroundStyle(.white)
          .frame(width: 16, height: 16)
        // 인증매물
        Text(L10n.commonCertifiedAuction)
          .foregroundStyle(Asset.Colors.neutralWhite.color)
          .fonts(.bodyMicroMedium)
      }
      .frame(height: 24)
      .padding(.horizontal, 6)
      .background {
        LinearGradient(colors: [Asset.Colors.commonGradientStart.color, Asset.Colors.commonGradientEnd.color], startPoint: .topLeading, endPoint: .bottomTrailing)
      }
      .clipShape(RoundedRectangle(cornerRadius: 8))
      
      // 유찰 n회
      Text(L10n.commonFailedBidCount(2))
        .fonts(.bodyMicroMedium)
        .foregroundStyle(Asset.Colors.neutralSubtler.color)
        .padding(.horizontal, 6)
        .frame(height: 24)
        .background {
          Asset.Colors.neutralWeak.color
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
      
      Text("매각 D-2")
        .fonts(.bodyMicroMedium)
        .foregroundStyle(Asset.Colors.critical.color)
        .padding(.horizontal, 6)
        .frame(height: 24)
        .background {
          Asset.Colors.criticalWeak.color
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
      
      Text("매각 D-4")
        .fonts(.bodyMicroMedium)
        .foregroundStyle(Asset.Colors.neutralSubtler.color)
        .padding(.horizontal, 6)
        .frame(height: 24)
        .background {
          Asset.Colors.neutralWeak.color
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
      
      Spacer()
    }
  }
}
