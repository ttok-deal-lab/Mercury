//
//  FontExtensinos.swift
//  UIComponent
//
//  Created by 송하민 on 3/30/25.
//

import Foundation
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

public extension View {
  func fonts(_ mercuryFont: MercuryFont) -> some View {
    modifier(MercuryFontModifier(mercuryFont: mercuryFont))
  }
}
