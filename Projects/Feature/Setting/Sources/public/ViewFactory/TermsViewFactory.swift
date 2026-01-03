//
//  AgreementViewFactory.swift
//  MyPage
//
//  Created by 최수훈 on 11/8/25.
//

import Foundation
import SwiftUI
import Combine

import Domain
import Router

public struct TermsViewFactory: ViewFactory {
  
  public init() { }
  
  public func makeView(_ agreementRouter: TermsRoute) -> some View {
    switch agreementRouter.route {
    case .termsList:
      TermsView()
    case .memberAgreement, .privacyPolicy, .servicePolicy:
      if let termsType = mapTermsType(agreementRouter.route) {
        TermsDetailView(type: termsType)
      }
    }
  }
  
  private func mapTermsType(_ route: TermsRoute.Route) -> TermsType? {
    switch route {
    case .memberAgreement:
      return .memberAgreement
    case .privacyPolicy:
      return .privacyPolicy
    case .servicePolicy:
      return .servicePolicy
    default:
      return nil
    }
  }
}
