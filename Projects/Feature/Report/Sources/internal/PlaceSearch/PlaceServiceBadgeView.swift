//
//  PlaceServiceBadgeView.swift
//  Report
//
//  Created by 최수훈 on 10/10/26.
//

import SwiftUI

import UIComponent

/// "서비스 가능 지역" 뱃지
struct PlaceServiceBadgeView: View {
  var body: some View {
    Text(L10n.reportPlaceServiceAvailable)
      .fonts(.captionLargeMedium)
      .foregroundStyle(Asset.Colors.primary.color)
      .padding(.horizontal, 6)
      .padding(.vertical, 3)
      .background(Asset.Colors.primaryLight.color)
      .clipShape(RoundedRectangle(cornerRadius: 4))
  }
}
