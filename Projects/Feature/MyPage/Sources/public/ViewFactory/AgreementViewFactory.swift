//
//  AgreementViewFactory.swift
//  MyPage
//
//  Created by 최수훈 on 11/8/25.
//

import Foundation
import SwiftUI
import Combine

import Router

public struct AgreementViewFactory: ViewFactory {
  private let modelData: MyPageModelData
  
  public init(modelData: MyPageModelData) {
    self.modelData = modelData
  }
  
  public func makeView(
    _ agreementRouter: AgreementRoute,
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  ) -> some View {
    switch agreementRouter.route {
    case .agreements:
      AgreementsView()
    case .termsOfUser:
      EmptyView()
    case .privacy:
      EmptyView()
    }
  }
}
