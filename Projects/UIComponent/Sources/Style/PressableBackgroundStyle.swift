//
//  PressableBackgroundStyle.swift
//  UIComponent
//
//  Created by 송하민 on 6/8/25.
//

import SwiftUI

public struct PressableBackgroundStyle: ButtonStyle {
  var normalColor: Color = .clear
  var pressedColor: Color
  
  public init(pressedColor: Color) {
    self.pressedColor = pressedColor
  }

  public func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .background(configuration.isPressed ? pressedColor : normalColor)
  }
}
