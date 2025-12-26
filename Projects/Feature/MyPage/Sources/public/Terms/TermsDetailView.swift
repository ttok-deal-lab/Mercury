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
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  @State private var isLoading = true
  private var route: TermsDetailRoute
  
  init(route: TermsDetailRoute) {
    self.route = route
  }
  
  var body: some View {
    VStack(spacing: 0) {
      MercuryNavigationBar(nil) {
        Button {
          coordinator.pop()
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
//    switch route {
//    case .memberAgreement:
//      PolicyURL.memberAgreement
//    case .pivacyPolicy:
//      PolicyURL.privacyPolicy
//    case .servicewPolicy:
//      PolicyURL.servicePolicy
//    }
    return ""
  }
}


