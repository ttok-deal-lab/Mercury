//
//  CrewRoomAnalysisChipsView.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import SwiftUI

import UIComponent

struct CrewRoomAnalysisChipsView: View {
  
  let selectedTypes: [CrewAnalysisType]
  let onToggle: (CrewAnalysisType) -> Void
  
  var body: some View {
    HStack(spacing: 8) {
      ForEach(CrewAnalysisType.allCases, id: \.self) { type in
        ChipsView(title: type.title, isSelected: selectedTypes.contains(type)) {
          onToggle(type)
        }
      }
      
      Spacer()
    }
  }
}
