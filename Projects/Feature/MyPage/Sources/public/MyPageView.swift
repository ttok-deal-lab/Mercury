//
//  MyPageView.swift
//  Profile
//
//  Created by 송하민 on 8/3/24.
//

import SwiftUI
import Combine

import AppFoundation
import Router
import UIComponent
import Domain

public struct MyPageView: View {
  @State private var viewModel = MyPageModelData()
  @Inject private var accessTokenManager: AccessTokenManagable
  
  private var navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
  public init(navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    self.navigationStream = navigationStream
  }
  
  public var body: some View {
    VStack {
      Button {
        accessTokenManager.removeAccessToken()
      } label: {
        Text("로그아웃")
      }
    }

  }
  
}
