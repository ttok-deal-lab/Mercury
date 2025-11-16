//
//  RecentlySalesView.swift
//  MyPage
//
//  Created by 최수훈 on 11/16/25.
//

import Combine
import SwiftUI

import UIComponent
import Router

struct RecentlySalesView: View {
  private var navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
  init(navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    self.navigationStream = navigationStream
  }
  
    var body: some View {
      VStack {
        MercuryNavigationBar("최근 본 매물") {
          Button {
            navigationStream.send(.pop)
          } label: {
            Asset.Images.arrowLeft.image
          }
        }
        Text("RecentlySalesView")
      }
      .navigationBarBackButtonHidden()
    }
}

