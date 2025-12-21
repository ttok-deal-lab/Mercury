//
//  SettingViewFactory.swift
//  Onboard
//
//  Created by 최수훈 on 11/1/25.
//

import Foundation
import SwiftUI
import Combine

import Domain
import Router


public struct SettingViewFactory: ViewFactory {
  
  public init() { }
  
  public func makeView(
    _ settingRouter: SettingRoute,
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  ) -> some View {
    switch settingRouter.route {
    case .setting:
      SettingView(navigationStream: navigationStream)
    case .notification:
      NotificationView(navigationStream: navigationStream)
    case .version:
      EmptyView()
    case .signOut:
      SignOutView()
    case .license:
      OpenLicenseView()
    }
  }
}
