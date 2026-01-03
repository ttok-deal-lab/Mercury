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
  private let termsType: TermsItemType
  
  init(type: TermsItemType) {
    self.termsType = type
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
          url: termsType.webURL!,
          isLoading: $isLoading
        )
      }
      Spacer()
    }
    .navigationBarBackButtonHidden()
  }
}


