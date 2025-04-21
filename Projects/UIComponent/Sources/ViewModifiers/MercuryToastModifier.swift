//
//  MercuryToastModifier.swift
//  UIComponent
//
//  Created by 송하민 on 4/21/25.
//

import SwiftUI
import Combine

import AppFoundation

struct MercuryToastModifier: ViewModifier {
  @Inject private var toast: Toastable
  let isPresented: Bool
  let text: String
  let tintType: ToastTintType
  let timing: ToastTime
  
  init(
    isPresented: Bool,
    text: String,
    tintType: ToastTintType,
    timing: ToastTime
  ) {
    self.isPresented = isPresented
    self.text = text
    self.tintType = tintType
    self.timing = timing
  }
  
  func body(content: Content) -> some View {
    return content
      .onReceive(Just(isPresented)) { _ in
        toast.present(title: text, tintType: tintType, timing: timing)
      }
  }
}

public extension View {
  func toast(
    isPresented: Bool,
    text: String,
    tintType: ToastTintType = .common,
    timing: ToastTime = .medium
  ) -> some View {
    modifier(
      MercuryToastModifier(
        isPresented: isPresented,
        text: text,
        tintType: tintType,
        timing: timing
      )
    )
  }
}
