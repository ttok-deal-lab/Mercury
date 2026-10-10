//
//  CrewLeaderIntroEditorView.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import SwiftUI

import UIComponent

struct CrewLeaderIntroEditorView: View {
  
  @Binding var text: String
  let placeholder: String
  
  var body: some View {
    ZStack(alignment: .topLeading) {
      if text.isEmpty {
        Text(placeholder)
          .fonts(.bodySmallMedium)
          .foregroundStyle(Asset.Colors.neutralSubtle.color)
          .padding(.horizontal, 16)
          .padding(.vertical, 14)
      }
      
      TextEditor(text: $text)
        .fonts(.bodySmallMedium)
        .foregroundStyle(Asset.Colors.neutral.color)
        .scrollContentBackground(.hidden)
        .padding(.horizontal, 11)
        .padding(.vertical, 6)
    }
    .frame(height: 200)
    .background(Asset.Colors.neutralLight.color)
    .clipShape(RoundedRectangle(cornerRadius: 8))
  }
}
