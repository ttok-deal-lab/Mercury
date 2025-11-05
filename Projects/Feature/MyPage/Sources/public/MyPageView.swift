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
  @State private var items: [String] = ["최근 본 매물", "1:1 문의"]
  @State private var icons: [Image] = [Asset.Images.home.image, Asset.Images.chat.image]
  
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
      MercuryNavigationBar(
        rightButtons: {
          Button {
            navigationStream.send(.push(.setting(.init(route: .setting))))
          } label: {
            Asset.Images.settingBlack.image
          }
      })
      UserProfileView(modelData: $modelData)
      
      Divider()
      
      MenuItemView(items: items, icons: icons) {
        print("asdlkjfal;kdj")
      }
      .padding(.vertical, 16)
      .padding(.horizontal, 20)
      
      // FIXME: 삭제
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
