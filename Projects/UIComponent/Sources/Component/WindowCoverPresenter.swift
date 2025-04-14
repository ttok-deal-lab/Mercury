//
//  WindowCoverPresenter.swift
//  UIComponent
//
//  Created by 송하민 on 4/12/25.
//

import SwiftUI
import UIKit
import Foundation

final class WindowCoverPresenter<Content: View> {
  private var window: UIWindow?
  
  func present(content: Content) {
    guard window == nil,
          let scene = UIApplication.shared.connectedScenes.first(where: {
            ($0.activationState == .foregroundActive) && ($0 is UIWindowScene)
          }) as? UIWindowScene else {
      return
    }
    
    let hostingController = UIHostingController(rootView: content)
    hostingController.view.backgroundColor = .clear
    
    let newWindow = UIWindow(windowScene: scene)
    newWindow.frame = UIScreen.main.bounds
    newWindow.backgroundColor = .clear
    newWindow.windowLevel = .alert + 1
    newWindow.rootViewController = hostingController
    self.window = newWindow
    newWindow.makeKeyAndVisible()
  }
  
  func dismiss() {
    window?.isHidden = true
    window = nil
  }
}
