//
//  ReportCrewFilterView.swift
//  Report
//
//  Created by 최수훈 on 10/8/26.
//

import SwiftUI

import UIComponent

struct ReportCrewFilterView: View {
  
  let selectedFilter: ReportCrewFilterType
  let onSelect: (ReportCrewFilterType) -> Void
  
  var body: some View {
    HStack(spacing: 12) {
      ForEach(ReportCrewFilterType.allCases, id: \.self) { filter in
        Button {
          onSelect(filter)
        } label: {
          filterLabel(filter, isSelected: filter == selectedFilter)
        }
      }
      
      Spacer()
    }
  }
  
  @ViewBuilder
  private func filterLabel(_ filter: ReportCrewFilterType, isSelected: Bool) -> some View {
    switch filter {
    case .all:
      Text(L10n.reportFilterAll)
        .fonts(.titleMediumBold)
        .foregroundStyle(isSelected ? Asset.Colors.neutral.color : Asset.Colors.neutralSubtler.color)
    case .mine:
      Asset.Images.person.image
        .renderingMode(.template)
        .resizable()
        .scaledToFit()
        .foregroundStyle(Asset.Colors.neutralSubtle.color)
        .padding(8)
        .frame(width: 36, height: 36)
        .background(Asset.Colors.gray150.color)
        .clipShape(Circle())
        .overlay {
          Circle()
            .stroke(isSelected ? Asset.Colors.primary.color : .clear, lineWidth: 2)
        }
    }
  }
}
