//
//  CrewRoomDatePickerSheetView.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import SwiftUI

import UIComponent

struct CrewRoomDatePickerSheetView: View {
  
  @State private var date: Date
  private let onConfirm: (Date) -> Void
  
  init(initialDate: Date, onConfirm: @escaping (Date) -> Void) {
    _date = State(initialValue: initialDate)
    self.onConfirm = onConfirm
  }
  
  var body: some View {
    VStack(spacing: 16) {
      DatePicker("", selection: $date, displayedComponents: .date)
        .datePickerStyle(.graphical)
        .labelsHidden()
      
      MercuryButton(L10n.commonConfirm) {
        onConfirm(date)
      }
    }
    .padding(.horizontal, 20)
  }
}
