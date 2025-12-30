//
//  AgreementsView.swift
//  MyPage
//
//  Created by 최수훈 on 11/8/25.
//

import SwiftUI
import Combine

import UIComponent
import Router

struct TermsView: View {
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  private let items: [TermsDetailRoute] = TermsDetailRoute.allCases
  
  public init() { }
  
  var body: some View {
    VStack(spacing: 0) {
      MercuryNavigationBar(L10n.settingTerms) {
        Button {
          coordinator.pop()
        } label: {
          Asset.Images.arrowLeft.image
        }
      }
      
      ForEach(items, id: \.self) { item in
        MercuryMenuItemView(item: item.title, left: .textLabel, rightView: {
          Asset.Images.arrowRightNoShaftGray.image
        }) {
          coordinator
            .push(.setting(.init(route: .terms(.init(route: .termsDetail(detailItemType: item))))))
        }
      }
      
      Spacer()
    }
    .navigationBarBackButtonHidden()
  }
}

extension TermsDetailRoute {
  var title: String {
    switch self {
    case .memberAgreement:
      L10n.settingAgreement
    case .pivacyPolicy:
      L10n.settingPrivacyPolicy
    case .servicewPolicy:
      L10n.settingServiceOperationPolicy
    }
  }
}
