//
//  UnderlineText.swift
//  UIComponent
//
//  Created by 최수훈 on 11/10/25.
//

import SwiftUI

public struct UnderlineText: ViewModifier {
  
  let offset: CGFloat
  let lineHeight: CGFloat
  let color: Color
  
  public func body(content: Content) -> some View {
    content
      .background(
        GeometryReader { geometry in
          Rectangle()
            .fill(color)
            .frame(height: lineHeight)
            .offset(y: geometry.size.height + offset)
          
        }
      )
  }
}

extension View {
  public func mercuryUnderLine(
    offset: CGFloat = 1,
    lineHeight: CGFloat = 1,
    color: Color = Asset.Colors.neutralSubtler.color
  ) -> some View {
    self.modifier(
      UnderlineText(
        offset: offset,
        lineHeight: lineHeight,
        color: color
      )
    )
  }
}
