//
//  ShadowExtension.swift
//  UIComponent
//
//  Created by 송하민 on 4/12/25.
//

import SwiftUI

public extension View {
  func shadows(_ shadowDefine: ShadowDefine) -> some View {
    modifier(ShadowModifier(type: shadowDefine))
  }
}
