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

enum TermItemType: CaseIterable {
  case agreement
  case privacy
  case servicePolicy
  
  var title: String {
    switch self {
    case .agreement:
      L10n.settingAgreement
    case .privacy:
      L10n.settingPrivacyPolicy
    case .servicePolicy:
      L10n.settingServiceOperationPolicy
    }
  }
}

struct TermsView: View {
  
  private let items: [TermItemType] = TermItemType.allCases
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
  
  private func onTap(_ item: TermItemType) {
    switch item {
    case .agreement:
      navigationStream.send(.push(.terms(.init(route: .agreement))))
    case .privacy:
      navigationStream.send(.push(.terms(.init(route: .privacy))))
    case .servicePolicy:
      navigationStream.send(.push(.terms(.init(route: .servicePolicy))))
    }
  }
}



