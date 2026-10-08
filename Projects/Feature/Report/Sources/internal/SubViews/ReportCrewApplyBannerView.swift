//
//  ReportCrewApplyBannerView.swift
//  Report
//
//  Created by 최수훈 on 10/8/26.
//

import SwiftUI

import UIComponent

struct ReportCrewApplyBannerView: View {
  
  let onApply: () -> Void
  
  var body: some View {
    HStack(alignment: .center, spacing: 12) {
      VStack(alignment: .leading, spacing: 4) {
        Text(L10n.reportLeaderApplyTitle)
          .fonts(.bodyMediumBold)
          .foregroundStyle(Asset.Colors.neutral.color)
        
        Text(L10n.reportLeaderApplyDesc)
          .fonts(.bodySmallRegular)
          .foregroundStyle(Asset.Colors.neutralSubtle.color)
      }
      
      Spacer()
      
      Button {
        onApply()
      } label: {
        Text(L10n.reportLeaderApplyButton)
          .fonts(.bodySmallBold)
          .foregroundStyle(Asset.Colors.neutralWhite.color)
          .padding(.horizontal, 16)
          .padding(.vertical, 10)
          .background(Asset.Colors.primary.color)
          .clipShape(RoundedRectangle(cornerRadius: 8))
      }
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 16)
    .background(Asset.Colors.neutralWhite.color)
  }
}
