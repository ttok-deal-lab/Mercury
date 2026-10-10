//
//  ReportCrewApplyBannerView.swift
//  Report
//
//  Created by 최수훈 on 10/8/26.
//

import SwiftUI

import UIComponent

/// 상단 배너. 크루장이 아니면 신청 안내, 크루장이면 크루 만들기 안내를 보여준다.
struct ReportCrewApplyBannerView: View {
  
  let isCrewLeader: Bool
  let onTap: () -> Void
  
  private var title: String {
    isCrewLeader ? L10n.reportLeaderBannerTitle : L10n.reportLeaderApplyTitle
  }
  
  private var buttonTitle: String {
    isCrewLeader ? L10n.reportLeaderBannerButton : L10n.reportLeaderApplyButton
  }
  
  var body: some View {
    HStack(alignment: .center, spacing: 12) {
      VStack(alignment: .leading, spacing: 4) {
        Text(title)
          .fonts(.bodyMediumBold)
          .foregroundStyle(Asset.Colors.neutral.color)
        
        Text(L10n.reportLeaderApplyDesc)
          .fonts(.bodySmallRegular)
          .foregroundStyle(Asset.Colors.neutralSubtle.color)
      }
      
      Spacer()
      
      Button {
        onTap()
      } label: {
        Text(buttonTitle)
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
