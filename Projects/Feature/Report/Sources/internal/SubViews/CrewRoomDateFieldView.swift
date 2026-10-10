//
//  CrewRoomDateFieldView.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import SwiftUI

import UIComponent

struct CrewRoomDateFieldView: View {
  
  let text: String?
  let placeholder: String
  let onTap: () -> Void
  
  var body: some View {
    Button(action: onTap) {
      HStack(spacing: 8) {
        Text(text ?? placeholder)
          .fonts(.bodySmallMedium)
          .foregroundStyle(text == nil ? Asset.Colors.neutralSubtle.color : Asset.Colors.neutral.color)
        
        Spacer()
        
        Asset.Images.calendar2.image
          .renderingMode(.template)
          .resizable()
          .scaledToFit()
          .foregroundStyle(Asset.Colors.neutralSubtle.color)
          .frame(width: 20, height: 20)
      }
      .padding(.horizontal, 16)
      .frame(height: 48)
      .overlay {
        RoundedRectangle(cornerRadius: 8)
          .stroke(Asset.Colors.gray100BorderDefault.color, lineWidth: 1)
      }
    }
  }
}
