//
//  VIewDidLoadModifier.swift
//  AppFoundation
//
//  Created by 송하민 on 4/21/25.
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
  @State private var didLoad = false
  private let action: (() -> Void)?
  
  init(_ action: (() -> Void)? = nil) {
    self.action = action
  }
  
  func body(content: Content) -> some View {
    content.onAppear {
      if didLoad == false {
        self.didLoad = true
        action?()
      }
    }
  }
}

public extension View {
  func onLoad(action: (() -> Void)? = nil) -> some View {
    self.modifier(ViewDidLoadModifier(action))
  }
}
