//
//  AgreementsView.swift
//  MyPage
//
//  Created by 최수훈 on 11/8/25.
//

import SwiftUI
import Combine

import UIComponent
import Domain
import Router

struct TermsView: View {
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  private let items: [TermsType] = [
    .memberAgreement,
    .privacyPolicy,
    .servicePolicy
  ]
  
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
      
      ForEach(items, id: \.self) { type in
        MercuryMenuItemView(item: type.displayTitle, left: .textLabel, rightView: {
          Asset.Images.arrowRightNoShaftGray.image
        }) {
          onItemTap(termsType: type)
        }
      }
      
      Spacer()
    }
    .navigationBarBackButtonHidden()
  }
  
  func onItemTap(termsType: TermsType) {
    switch termsType {
    case .memberAgreement:
      coordinator.push(.terms(.init(route: .memberAgreement)))
    case .privacyPolicy:
      coordinator.push(.terms(.init(route: .privacyPolicy)))
    case .servicePolicy:
      coordinator.push(.terms(.init(route: .servicePolicy)))
    }
  }
}
