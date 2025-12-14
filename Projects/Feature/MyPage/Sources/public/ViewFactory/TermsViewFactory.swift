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

public struct TermsViewFactory: ViewFactory {
  
  public init() { }
  
  public func makeView(
    _ agreementRouter: TermsRoute,
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  ) -> some View {
    switch agreementRouter.route {
    case .terms:
      TermsView(navigationStream: navigationStream)
    case .agreement:
      AgreementView(navigationStream: navigationStream)
    case .privacy:
      PrivacyView(navigationStream: navigationStream)
    }
  }
}
