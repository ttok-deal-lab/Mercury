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

enum TermItemType: String, CaseIterable {
  case agreement = "회원 이용약관"
  case privacy = "개인정보처리방침"
}

struct TermsView: View {
  
  private let items: [String] = TermItemType.allCases.map(\.rawValue)
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
        MercuryMenuItemView(item: item, left: .textLabel, rightView: {
          Asset.Images.arrowRightNoShaftGray.image
        }) {
          onTap(item)
        }
      }
      
      Spacer()
    }
    .navigationBarBackButtonHidden()
  }
  
  private func onTap(_ item: String) {
    guard let item = TermItemType(rawValue: item) else { return }
    switch item {
    case .agreement:
      navigationStream.send(.push(.terms(.init(route: .agreement))))
    case .privacy:
      navigationStream.send(.push(.terms(.init(route: .privacy))))
    }
  }
}



