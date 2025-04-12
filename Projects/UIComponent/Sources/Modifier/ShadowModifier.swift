//
//  ShadowModifier.swift
//  UIComponent
//
//  Created by 송하민 on 4/12/25.
//

import SwiftUI

public struct ShadowModifier: ViewModifier {
  let type: ShadowDefine
  
  public func body(content: Content) -> some View {
    return content
      .shadow(color: Asset.Colors.shadow.color.opacity(type.opacity), radius: type.blur, x: type.xDirection, y: type.yDirection)
  }
}
