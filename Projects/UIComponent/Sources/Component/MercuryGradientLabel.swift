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
      Text(L10n.commonCertifiedAuction)
        .foregroundStyle(Asset.Colors.neutralWhite.color)
        .fonts(.captionLargeMedium)
        .lineLimit(1)
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
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
  }
}
