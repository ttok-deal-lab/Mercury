//
//  CrewLeaderTextFieldView.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import SwiftUI

import UIComponent

struct CrewLeaderTextFieldView: View {
  
  @Binding var text: String
  let placeholder: String
  var isPhoneNumber: Bool = false
  var isNumeric: Bool = false
  var showsClearButton: Bool = false
  
  var body: some View {
    HStack(spacing: 8) {
      ZStack(alignment: .leading) {
        if text.isEmpty {
          Text(placeholder)
            .fonts(.bodySmallMedium)
            .foregroundStyle(Asset.Colors.neutralSubtle.color)
        }
        
        TextField("", text: $text)
          .fonts(.bodySmallMedium)
          .foregroundStyle(Asset.Colors.neutral.color)
          .keyboardType(isPhoneNumber ? .phonePad : (isNumeric ? .numberPad : .default))
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled()
      }
      
      if showsClearButton && !text.isEmpty {
        Button {
          text = ""
        } label: {
          Asset.Images.close.image
            .renderingMode(.template)
            .resizable()
            .frame(width: 16, height: 16)
            .foregroundStyle(Asset.Colors.neutralSubtler.color)
        }
      }
    }
    .padding(.horizontal, 16)
    .frame(height: 48)
    .background(Asset.Colors.neutralLight.color)
    .clipShape(RoundedRectangle(cornerRadius: 8))
  }
}
