//
//  VisitTimeDropdownView.swift
//  Report
//
//  Created by 최수훈 on 10/10/26.
//

import SwiftUI

import UIComponent

/// 시 또는 분 드롭다운
struct VisitTimeDropdownView: View {
  let placeholder: String
  let values: [Int]
  @Binding var selected: Int?
  
  var body: some View {
    Menu {
      ForEach(values, id: \.self) { value in
        Button(String(format: "%02d", value)) {
          selected = value
        }
      }
    } label: {
      HStack {
        Text(selected.map { String(format: "%02d", $0) } ?? placeholder)
          .fonts(.bodySmallMedium)
          .foregroundStyle(selected == nil ? Asset.Colors.neutralSubtle.color : Asset.Colors.neutral.color)
        Spacer()
        Asset.Images.chevronDown.image
          .resizable()
          .frame(width: 16, height: 16)
      }
      .padding(.horizontal, 12)
      .frame(height: 44)
      .frame(maxWidth: .infinity)
      .overlay {
        RoundedRectangle(cornerRadius: 8)
          .stroke(Asset.Colors.gray100BorderDefault.color, lineWidth: 1)
      }
    }
  }
}
