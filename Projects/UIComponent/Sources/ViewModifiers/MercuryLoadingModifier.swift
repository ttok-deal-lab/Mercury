//
//  MercuryLoadingModifier.swift
//  UIComponent
//
//  Created by 송하민 on 4/19/25.
//

import SwiftUI

struct MercuryLoadingModifier: ViewModifier {
  var isLoading: Bool = false
  var loadingView = MercuryLoading.shared
  
  func body(content: Content) -> some View {
    content
      .onDisappear {
        loadingView.hide()
      }
      .onChange(of: isLoading) { oldValue, newValue in
        guard oldValue != newValue else { return }
        if newValue {
          loadingView.show()
        } else {
          loadingView.hide()
        }
      }
  }
}

public extension View {
  func loading(_ isLoading: Bool) -> some View {
    self.modifier(MercuryLoadingModifier(isLoading: isLoading))
  }
}
