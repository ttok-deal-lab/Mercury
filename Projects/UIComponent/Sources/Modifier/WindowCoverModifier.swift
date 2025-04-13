//
//  WindowCoverModifier.swift
//  UIComponent
//
//  Created by 송하민 on 4/12/25.
//

import SwiftUI

struct WindowCoverModifier<Cover: View>: ViewModifier {
  @Binding var isPresented: Bool
  let cover: () -> Cover
  
  @State private var presenter = WindowCoverPresenter<Cover>()
  
  func body(content: Content) -> some View {
    content
      .onChange(of: isPresented) { oldValue, newValue in
        if newValue {
          presenter.present(content: cover())
        } else {
          presenter.dismiss()
        }
      }
  }
}

public extension View {
  func alerts<Content: View>(isPresented: Binding<Bool>, @ViewBuilder cover: @escaping () -> Content) -> some View {
    self.modifier(WindowCoverModifier(isPresented: isPresented, cover: cover))
  }
}
