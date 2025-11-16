//
//  AgreementView.swift
//  MyPage
//
//  Created by 최수훈 on 11/10/25.
//

import SwiftUI
import Combine

import UIComponent
import Router

struct AgreementView: View {
  
  private let navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
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
        Text("AgreementView")
        Spacer()
      }
      .navigationBarBackButtonHidden()
    }
}
