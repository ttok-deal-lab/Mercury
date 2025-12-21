//
//  TermsDetailView.swift
//  MyPage
//
//  Created by 최수훈 on 12/20/25.
//

import Combine
import SwiftUI


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
    switch route {
    case .memberAgreement:
      return "https://www.notion.so/v1-2ba5ff9f915c80f4b458ef4d48083820?source=copy_link"
    case .pivacyPolicy:
      return "https://www.notion.so/iOS-ver-1-2ba5ff9f915c80ad9e59e6a365337e52?source=copy_link"
    case .servicewPolicy:
      return "https://www.notion.so/ver-1-2ba5ff9f915c807d84e1d65fa44177e1?source=copy_link"
    }
  }
}
  
  
