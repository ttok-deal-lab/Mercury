//
//  CrewRoomPeriodPickerSheetView.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import SwiftUI

import UIComponent

struct CrewRoomPeriodPickerSheetView: View {
  
  @State private var start: Date
  @State private var end: Date
  private let onConfirm: (Date, Date) -> Void
  
  init(initialStart: Date, initialEnd: Date, onConfirm: @escaping (Date, Date) -> Void) {
    _start = State(initialValue: initialStart)
    _end = State(initialValue: max(initialStart, initialEnd))
    self.onConfirm = onConfirm
  }
  
  var body: some View {
    VStack(spacing: 16) {
      DatePicker(L10n.reportCrewCreatePeriodStart, selection: $start, displayedComponents: .date)
        .fonts(.bodySmallMedium)
        .foregroundStyle(Asset.Colors.neutral.color)
      
      DatePicker(L10n.reportCrewCreatePeriodEnd, selection: $end, in: start..., displayedComponents: .date)
        .fonts(.bodySmallMedium)
        .foregroundStyle(Asset.Colors.neutral.color)
      
      MercuryButton(L10n.commonConfirm) {
        onConfirm(start, end)
      }
      .padding(.top, 8)
    }
    .padding(.horizontal, 20)
    .onChange(of: start) { _, newStart in
      if end < newStart { end = newStart }
    }
  }
}
