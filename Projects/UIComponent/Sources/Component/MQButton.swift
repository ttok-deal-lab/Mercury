//
//  MQButton.swift
//  UIComponent
//
//  Created by 송하민 on 10/4/24.
//

import SwiftUI
import Foundation

public struct MQButton: View {
  
  var title: String
  var font: MercuryFont
  var backgroundColor: Color
  var foregroundColor: Color
  var action: () -> Void
  var cornerRadius: CGFloat = 16
  var horizontalPadding: CGFloat = 20
  
  public init(
    title: String,
    font: MercuryFont = .bodyMediumMedium,
    backgroundColor: Color = .black,
    foregroundColor: Color = .white,
    action: @escaping () -> Void,
    cornerRadius: CGFloat = 16,
    horizontalPadding: CGFloat = 20
  ) {
    self.title = title
    self.font = font
    self.backgroundColor = backgroundColor
    self.foregroundColor = foregroundColor
    self.action = action
    self.cornerRadius = cornerRadius
    self.horizontalPadding = horizontalPadding
  }
  
  public var body: some View {
    Button {
      action()
    } label: {
      Text(title)
        .fonts(font)
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .foregroundStyle(foregroundColor)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
    .padding(.horizontal, horizontalPadding)

  }
}
