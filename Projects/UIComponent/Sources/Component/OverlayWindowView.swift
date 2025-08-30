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
      .onAppear {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, overlayWindow == nil {
          let window = PassthroughWindow(windowScene: windowScene)
          window.backgroundColor = .clear
          
          let rootViewController = UIHostingController(rootView: OverlayGroup())
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
    if #available(iOS 18, *) {
      let view = super.hitTest(point, with: event)
      guard let view, _hitTest(point, from: view) != rootViewController?.view else { return nil }
      return view
    } else {
      guard let hitView = super.hitTest(point, with: event) else { return nil }
      if rootViewController?.view == hitView {
        return nil
      } else if hitView.subviews.last is PassthroughView {
        return nil
      } else {
        return hitView
      }
    }
  }
  
  private func _hitTest(_ point: CGPoint, from view: UIView) -> UIView? {
    let converted = convert(point, to: view)
    
    guard view.bounds.contains(converted)
            && view.isUserInteractionEnabled
            && !view.isHidden
            && view.alpha > 0
    else {
      return nil
    }
    
    return view.subviews.reversed()
      .reduce(Optional<UIView>.none) { result, view in
        result ?? _hitTest(point, from: view)
      } ?? view
  }
}

private class PassthroughView: UIView {
  private var onHitView: (() -> Void)?
  
  public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    onHitView?()
    return nil
  }
  
  public func onHit(_ closure: (() -> Void)?) {
    onHitView = closure
  }
}
