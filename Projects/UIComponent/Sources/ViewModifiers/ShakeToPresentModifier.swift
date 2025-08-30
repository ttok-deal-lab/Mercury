//
//  ShakeToOpenPulseModifier.swift
//  UIComponent
//
//  Created by 송하민 on 4/27/25.
//

import SwiftUI

struct ShakeToPresentModifier: ViewModifier {
  var onPresent: () -> Void
  func body(content: Content) -> some View {
    content
#if DEBUG
      .onReceive(NotificationCenter.default.publisher(for: .deviceDidShakeNotification)) { _ in
        onPresent()
      }
#endif
    
  }
}

public extension View {
  func shake(onPresent: @escaping () -> Void) -> some View {
    modifier(ShakeToPresentModifier(onPresent: onPresent))
  }
}
