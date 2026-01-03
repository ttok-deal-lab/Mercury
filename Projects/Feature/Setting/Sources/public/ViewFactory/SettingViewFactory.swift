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
  
  // MARK: - pricate properties
  private let settingUsecase: SettingUsecasable
  public init(settingUsecase: SettingUsecasable) {
    self.settingUsecase = settingUsecase
  }
  
  public func makeView(_ settingRouter: SettingRoute) -> some View {
    switch settingRouter.route {
    case .settingList:
      SettingView()
    case .version:
      EmptyView()
    case .signOut:
      SignOutView(settingUsecase: settingUsecase)
    case .license:
      OpenLicenseView()
    }
  }
}
