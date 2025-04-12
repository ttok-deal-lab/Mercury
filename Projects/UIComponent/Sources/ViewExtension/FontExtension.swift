//
//  FontExtensinos.swift
//  UIComponent
//
//  Created by 송하민 on 3/30/25.
//

import Foundation
import SwiftUI

public extension View {
  func fonts(_ mercuryFont: MercuryFont) -> some View {
    modifier(MercuryFontModifier(mercuryFont: mercuryFont))
  }
}
