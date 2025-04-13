//
//  PassthroughWindowView.swift
//  UIComponent
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import UIKit

public struct ToastWindowView<Content: View>: View {
  @ViewBuilder public var content: Content
  @State private var overlayWindow: UIWindow?
  
  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  public var body: some View {
    content
      .onAppear {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, overlayWindow == nil {
          let window = PassthroughWindow(windowScene: windowScene)
          window.backgroundColor = .clear
          
          let rootViewController = UIHostingController(rootView: ToastGroup())
          rootViewController.view.frame = windowScene.keyWindow?.frame ?? .zero
          rootViewController.view.backgroundColor = .clear
          window.rootViewController = rootViewController
          
          window.isHidden = false
          window.isUserInteractionEnabled = true
          window.windowLevel = .alert + 1
          
          overlayWindow = window
        }
      }
  }
}

fileprivate class PassthroughWindow: UIWindow {
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    guard let view = super.hitTest(point, with: event) else { return nil }
    return rootViewController?.view == view ? nil : view
  }
}
