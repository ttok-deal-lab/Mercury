//
//  UIViewControllerExtensions.swift
//  UIComponent
//
//  Created by 송하민 on 10/4/24.
//

import UIKit

extension UIViewController {
  
  public static func getRootViewController() -> UIViewController? {
    guard let windowScene = UIApplication.shared.connectedScenes.filter({ $0.activationState == .foregroundActive }).first as? UIWindowScene,
          let rootViewController = windowScene.windows.filter({ $0.isKeyWindow }).first?.rootViewController else { return nil }
    return rootViewController
  }
  
  public static func topViewController() -> UIViewController? {
    var topController = getRootViewController()
    while let presentedViewController = topController?.presentedViewController {
      topController = presentedViewController
    }
    return topController
  }
}
