//
//  MQButton.swift
//  UIComponent
//
//  Created by 송하민 on 10/4/24.
//

import SwiftUI
import Foundation

struct MQButton: View {
  
  var title: String
  var font: Font
  var backgroundColor: Color
  var foregroundColor: Color
  var action: () -> Void
  var cornerRadius: CGFloat = 16
  
  var body: some View {
    Button {
      action()
    } label: {
      Text(title)
        .font(font)
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .foregroundStyle(foregroundColor)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }

  }
}

#Preview {
  MQButton(
    title: "Hellowww",
    font: .headline,
    backgroundColor: .black,
    foregroundColor: .white,
    action: {
      print("ya")
    },
    cornerRadius: 24
  )
}
