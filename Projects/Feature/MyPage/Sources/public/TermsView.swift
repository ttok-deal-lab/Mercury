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
  
  private let items: [TermsDetailRoute] = TermsDetailRoute.allCases
  private let navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
  public init(navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    self.navigationStream = navigationStream
  }
  
  var body: some View {
    VStack(spacing: 0) {
      MercuryNavigationBar(L10n.settingTerms) {
        Button {
          navigationStream.send(.pop)
        } label: {
          Asset.Images.arrowLeft.image
        }
      }
      
      ForEach(items, id: \.self) { item in
        MercuryMenuItemView(item: item.title, left: .textLabel, rightView: {
          Asset.Images.arrowRightNoShaftGray.image
        }) {
          onTap(item)
        }
      }
      
      Spacer()
    }
    .navigationBarBackButtonHidden()
  }
  
  private func onTap(_ item: TermsDetailRoute) {
    navigationStream.send(.push(.terms(.init(route: .termsDetail(detailItemType: item)))))
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
