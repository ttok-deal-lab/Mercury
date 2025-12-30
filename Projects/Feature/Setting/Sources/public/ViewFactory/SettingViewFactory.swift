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
  
  public func makeView(_ settingRouter: SettingRoute) -> some View {
    switch settingRouter.route {
    case .settingList:
      SettingView()
    case .terms(let agreementStep):
      TermsViewFactory()
        .makeView(agreementStep)
    case .version:
      EmptyView()
    case .signOut:
      SignOutView()
    case .license:
      OpenLicenseView()
    }
  }
}
