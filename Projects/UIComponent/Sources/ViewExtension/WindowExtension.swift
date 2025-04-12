//
//  WindowExtension.swift
//  UIComponent
//
//  Created by 송하민 on 4/12/25.
//

import SwiftUI

public extension View {
  func windowCover<Content: View>(isPresented: Binding<Bool>, @ViewBuilder cover: @escaping () -> Content) -> some View {
    self.modifier(WindowCoverModifier(isPresented: isPresented, cover: cover))
  }
}

