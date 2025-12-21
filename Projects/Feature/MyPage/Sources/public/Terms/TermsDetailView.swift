//
//  TermsDetailView.swift
//  MyPage
//
//  Created by 최수훈 on 12/20/25.
//

import Combine
import SwiftUI

import AppFoundation
import UIComponent
import Router

struct TermsDetailView: View {
  
  private let navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  @State private var isLoading = true
  private var route: TermsDetailRoute
  
  init(
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>,Never>,
    route: TermsDetailRoute
  ) {
    self.navigationStream = navigationStream
    self.route = route
  }
  
  var body: some View {
    VStack(spacing: 0) {
      MercuryNavigationBar(nil) {
        Button {
          navigationStream.send(.pop)
        } label: {
          Asset.Images.arrowLeftNoShaft.image
        }
      }
      
      ZStack {
        MercuryWebView(
          url: route.toURL(urlString: termsURL(route: route))!,
          isLoading: $isLoading
        )
      }
      
      Spacer()
    }
    .navigationBarBackButtonHidden()
  }
  
  private func termsURL(route: TermsDetailRoute) -> String {
    switch route {
    case .memberAgreement:
      PolicyURL.memberAgreement
    case .pivacyPolicy:
      PolicyURL.privacyPolicy
    case .servicewPolicy:
      PolicyURL.servicePolicy
    }
  }
}


