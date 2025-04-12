//
//  MercuryFontModifier.swift
//  UIComponent
//
//  Created by 송하민 on 4/12/25.
//

import SwiftUI
import UIKit

public struct MercuryFontModifier: ViewModifier {
  let mercuryFont: MercuryFont
  
  public func body(content: Content) -> some View {
    let font = UIFont(font: mercuryFont.font, size: mercuryFont.size)!
    let baselineOffset = (mercuryFont.lineHeight - font.lineHeight) / 2
    return content
      .font(.custom(mercuryFont.font.name, size: mercuryFont.size))
      .lineSpacing(mercuryFont.lineHeight - font.lineHeight)
      .baselineOffset(baselineOffset)
  }
}
