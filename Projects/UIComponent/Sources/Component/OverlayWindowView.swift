//
//  PassthroughWindowView.swift
//  UIComponent
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import UIKit

public struct OverlayGroup: View {
  public var body: some View {
    ZStack {
      // 전역적으로 나타나야 하는 컴포넌트가 있다면 추가
      ToastGroup()
      MercuryAlertView()
      MercuryLoadingView()
    }
  }
}

public struct OverlayWindowView<Content: View>: View {
  @ViewBuilder public var content: Content
  @State private var overlayWindow: UIWindow?
  
  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  public var body: some View {
    content
      .overlay(alignment: .center) {
        OverlayGroup()
          .allowsHitTesting(true)
      }
  }
}
