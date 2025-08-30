//
//  InformCertificationView.swift
//  Auction
//
//  Created by 송하민 on 5/4/25.
//

import SwiftUI

import AppFoundation
import UIComponent

struct InformCertificationView: View {
  var body: some View {
    VStack(spacing: .zero) {
      
      VStack(spacing: 5) {
        HStack(spacing: 4) {
          Asset.Images.certified.image
            .resizable()
            .frame(width: 22, height: 22)
          HStack(spacing: .zero) {
//            Text("인증매물")
            Text(L10n.auctionIntroduceCertifiedListingTitleA)
              .foregroundStyle(Asset.Colors.primary200TextSuccess.color)
              .fonts(.bodyMediumBold)
            Text(L10n.auctionIntroduceCertifiedListingTitleB)
              .foregroundStyle(Asset.Colors.neutral.color)
              .fonts(.bodyMediumBold)
          }
          Spacer()
        }
        
        HStack(spacing: .zero) {
          Text(L10n.auctionIntroduceCertifiedListingDescription)
            .foregroundStyle(Asset.Colors.neutralSubtler.color)
            .fonts(.bodyMiniMedium)
          Spacer()
        }
      }
      .padding(.vertical, 12)
      .padding(.horizontal, 20)
      
    }
    .background(Asset.Colors.gray50BackgroundMuted.color)
  }
}
