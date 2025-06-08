//
//  MercuryBottomSheet.swift
//  UIComponent
//
//  Created by 송하민 on 6/8/25.
//

import Foundation
import SwiftUI

public struct MercuryBottomSheetConfig {
  public var maxDetent: PresentationDetent
  public var cornerRadius: CGFloat
  public var isInteractiveDismissDisabled: Bool
  
  public init(maxDetent: PresentationDetent, cornerRadius: CGFloat = 30, isInteractiveDismissDisabled: Bool = false) {
    self.maxDetent = maxDetent
    self.cornerRadius = cornerRadius
    self.isInteractiveDismissDisabled = isInteractiveDismissDisabled
  }
}

public extension View {
  func dynamicSheet<Content: View>(
    isPresented: Binding<Bool>,
    config: MercuryBottomSheetConfig = .init(maxDetent: .fraction(0.99)),
    @ViewBuilder content: @escaping () -> Content
  ) -> some View {
    self
      .sheet(isPresented: isPresented) {
        ZStack {
          Color.white.opacity(0.001)
            .ignoresSafeArea()
            .onTapGesture {
              isPresented.wrappedValue = false
            }

          BottomSheetContainer(content: content)
            .frame(maxWidth: .infinity)
            .background(.background)
            .clipShape(.rect(cornerRadius: config.cornerRadius))
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(edges: .bottom)
            .presentationDetents([config.maxDetent])
            .presentationCornerRadius(0)
            .presentationBackground(.clear)
            .presentationDragIndicator(.hidden)
            .interactiveDismissDisabled(config.isInteractiveDismissDisabled)
        }
      }
  }
  
}

struct BottomSheetContainer<Content: View>: View {
  var content: () -> Content

  var body: some View {
    VStack(spacing: 0) {
      BottomSheetCustomHandle()
        .padding(.top, 6)
        .padding(.bottom, 24)
      content()
    }
    .safeAreaInset(edge: .bottom) {
      Color.clear.frame(height: 30)
    }
  }
}

struct BottomSheetCustomHandle: View {
  var body: some View {
    Capsule()
      .background(Asset.Colors.neutralWeak.color)
      .frame(width: 40, height: 4)
  }
}
