//
//  ReportCrewItemView.swift
//  Report
//
//  Created by 최수훈 on 10/8/26.
//

import SwiftUI

import UIComponent

struct ReportCrewItemView: View {
  
  let item: ReportCrewItem
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(item.status.title)
        .fonts(.captionLargeMedium)
        .foregroundStyle(item.status.textColor)
        .padding(.vertical, 3)
        .padding(.horizontal, 6)
        .background(item.status.backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 4))
      
      VStack(alignment: .leading, spacing: 2) {
        Text(L10n.reportCrewName(item.name))
          .fonts(.bodySmallRegular)
        
        Text(L10n.reportCrewStatus(item.status.title))
          .fonts(.bodySmallRegular)
        
        Text(L10n.reportCrewRemainingDays(item.remainingDays))
          .fonts(.bodySmallBold)
        
        Text(L10n.reportCrewCurrent(item.currentCount, item.capacity, item.successRate))
          .fonts(.bodySmallBold)
      }
      .foregroundStyle(Asset.Colors.neutral.color)
      .multilineTextAlignment(.leading)
    }
    .padding(20)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Asset.Colors.neutralWhite.color)
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .shadows(.shadowMedium)
  }
}
