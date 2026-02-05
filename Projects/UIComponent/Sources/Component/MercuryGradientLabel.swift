//
//  MercuryGradientLabel.swift
//  AuctionHome
//
//  Created by 최수훈 on 2/5/26.
//

import SwiftUI

public struct MercuryGradientLabel: View {
  var title: String?
  
  public init(title: String? = nil) {
    self.title = title
  }
  
  public var body: some View {
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
          .fonts(.captionLargeMedium)
      }
//      .frame(height: 24)
      .padding(.vertical, 3)
      .padding(.horizontal, 6)
      .background {
        LinearGradient(
          colors: [
            Asset.Colors.commonGradientStart.color,
            Asset.Colors.commonGradientEnd.color
          ],
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        )
      }
      .clipShape(RoundedRectangle(cornerRadius: 8))
    }
//    Label {
//      Text(title ?? "")
//        .fonts(.captionLargeMedium)
//    } icon: {
//      Asset.Images.certified.image
//        .resizable()
//        .renderingMode(.template)
//        .foregroundStyle(.white)
//        .frame(width: 16, height: 16)
//    }
//      .padding(.vertical, 3)
//      .padding(.horizontal, 6)
//      .foregroundStyle(.white)
//      .background(
//        LinearGradient(
//          colors: [
//            Asset.Colors.commonGradientStart.color,
//            Asset.Colors.commonGradientEnd.color
//          ],
//          startPoint: .topLeading,
//          endPoint: .bottomTrailing
//        )
//      )
//      .clipShape(RoundedRectangle(cornerRadius: 6))
  }
}
