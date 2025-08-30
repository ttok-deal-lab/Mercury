//
//  BottomSheetContainerModifier.swift
//  UIComponent
//
//  Created by 송하민 on 6/8/25.
//

import SwiftUI

struct BottomSheetContainerModifier: ViewModifier {
  @State private var height: CGFloat = .zero
  let cornerRadius: CGFloat

  func body(content: Content) -> some View {
    VStack(spacing: 0) {
      BottomSheetCustomHandle()
        .padding(.top, 6)
        .padding(.bottom, 24)

      content
    }
    .safeAreaInset(edge: .bottom) {
      Color.clear.frame(height: 30)
    }
    .background(Color(.systemBackground))
    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    .fixedSize(horizontal: false, vertical: true)
    .overlay(
      GeometryReader { geometry in
        Color.clear
          .preference(key: SizeKey.self, value: geometry.size.height)
      }
    )
    .onPreferenceChange(SizeKey.self) { newValue in
      self.height = newValue
    }
    .presentationDetents(height == .zero ? [.medium] : [.height(height)])
    .presentationDragIndicator(.hidden)
  }
}

public extension View {
  func dynamicSheet(cornerRadius: CGFloat = 30) -> some View {
    self.modifier(BottomSheetContainerModifier(cornerRadius: cornerRadius))
  }
}

struct BottomSheetCustomHandle: View {
  var body: some View {
    Capsule()
      .foregroundStyle(Asset.Colors.neutralMuted.color)
      .frame(width: 40, height: 4)
  }
}

struct SizeKey: PreferenceKey {
  static var defaultValue: CGFloat = .zero
  static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
    value = nextValue()
  }
}

extension View {
  @ViewBuilder
  func heightChangePreference(completion: @escaping (CGFloat) -> ()) -> some View {
    self
      .overlay {
        GeometryReader { geometry in
          Color.clear
            .preference(key: SizeKey.self, value: geometry.size.height)
            .onPreferenceChange(SizeKey.self, perform: { value in
              completion(value)
            })
        }
      }
  }
}
