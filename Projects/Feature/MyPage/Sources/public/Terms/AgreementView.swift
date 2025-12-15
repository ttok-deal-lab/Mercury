//
//  AgreementView.swift
//  MyPage
//
//  Created by 최수훈 on 11/10/25.
//

import SwiftUI
import Combine
import WebKit

import UIComponent
import Router

struct AgreementView: View {
  
  private let navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  @State private var isLoading = true
  
  init(navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    self.navigationStream = navigationStream
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
          url: URL(
            string: "https://www.notion.so/v1-2ba5ff9f915c80f4b458ef4d48083820?source=copy_link")!,
          isLoading: $isLoading
        )
      }
      
      Spacer()
    }
    .navigationBarBackButtonHidden()
  }
}
