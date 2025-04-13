//
//  ShadowModifier.swift
//  UIComponent
//
//  Created by 송하민 on 4/12/25.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
  let shadow: ShadowDefine
  
  func body(content: Content) -> some View {
    return content
      .shadow(color: Asset.Colors.shadow.color.opacity(shadow.opacity), radius: shadow.blur, x: shadow.xDirection, y: shadow.yDirection)
  }
}
