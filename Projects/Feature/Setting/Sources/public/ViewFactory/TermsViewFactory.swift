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
  
  public func makeView(_ agreementRouter: TermsRoute) -> some View {
    switch agreementRouter.route {
    case .termsList:
      TermsView()
    case .termsDetail(let detailItemType):
      TermsDetailView(route: detailItemType)
    }
  }
}
