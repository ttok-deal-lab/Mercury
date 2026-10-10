//
//  PlaceSearchGuideView.swift
//  Report
//
//  Created by 최수훈 on 10/10/26.
//

import SwiftUI

import UIComponent

/// 검색 전 안내: 어떤 조합으로 검색하면 정확한지 예시를 보여준다.
struct PlaceSearchGuideView: View {
  private let examples: [(title: String, example: String)] = [
    (L10n.reportPlaceSearchGuideRoad, L10n.reportPlaceSearchGuideRoadExample),
    (L10n.reportPlaceSearchGuideJibun, L10n.reportPlaceSearchGuideJibunExample),
    (L10n.reportPlaceSearchGuideBuilding, L10n.reportPlaceSearchGuideBuildingExample),
    (L10n.reportPlaceSearchGuidePobox, L10n.reportPlaceSearchGuidePoboxExample)
  ]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text(L10n.reportPlaceSearchGuideTitle)
        .fonts(.bodySmallMedium)
        .foregroundStyle(Asset.Colors.neutral.color)
      
      ForEach(examples, id: \.title) { item in
        VStack(alignment: .leading, spacing: 4) {
          Text(item.title)
            .fonts(.bodySmallMedium)
            .foregroundStyle(Asset.Colors.neutral.color)
          Text(item.example)
            .fonts(.bodyMicroRegular)
            .foregroundStyle(Asset.Colors.primary.color)
        }
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(20)
  }
}
