//
//  UIWindowExtension.swift
//  AppFoundation
//
//  Created by 송하민 on 4/26/25.
//

import UIKit

extension UIWindow {
  open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    guard motion == .motionShake else { return }
    NotificationCenter.default.post(name: .deviceDidShakeNotification, object: nil)
  }
}
