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
  @State private var modelData: MyPageModelData
  @State private var error: MercuryError?
  @State private var hasFetched = false
  @Inject private var accessTokenManager: AccessTokenManagable
  
  private var navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
  public init(
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>,
    userProfileUsecase: UserProfileUsecasable
  ) {
    self.navigationStream = navigationStream
    self.modelData = MyPageModelData(userProfileUsecasable: userProfileUsecase)
  }
  
  public var body: some View {
    VStack {
      UserInfoView(modelData: $modelData)
      Button {
        accessTokenManager.removeAccessToken()
      } label: {
        Text("로그아웃")
      }
      Spacer()
    } //: VStack
    .alert(error: $error)
    .task(priority: .high) {
      if hasFetched { return }
      hasFetched = true
      do {
        try await modelData.fetchProfile()
      } catch {
        self.error = error.toMercuryError()
      }
    }
    
  }
  
}
