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

enum MyPageItemType: CaseIterable {
  case recentlySales
  case chat
  
  var title: String {
    switch self {
    case .recentlySales: L10n.settingRecentViewSales
    case .chat: L10n.settingChat
    }
  }
  
  var icon: Image {
    switch self {
    case .recentlySales:
      Asset.Images.home.image
    case .chat:
      Asset.Images.chat.image
    }
  }
}

public struct MyPageView: View {
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  @State private var modelData: MyPageModelData
  @State private var error: Error?
  @State private var hasFetched = false
  @Inject private var accessTokenManager: AccessTokenManagable
  private var items: [MyPageItemType] = MyPageItemType.allCases
  
  public init(userProfileUsecase: MyPageUsecasable) {
    self.modelData = MyPageModelData(userProfileUsecasable: userProfileUsecase)
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      MercuryNavigationBar(
        rightButtons: {
          Button {
            coordinator.push(.setting(SettingRoute(route: .setting)))
          } label: {
            Asset.Images.settingBlack.image
              .padding(.vertical, 16)
          }
        })
      UserProfileView(modelData: $modelData)
        .padding(.bottom, 20)
      Divider()
      ForEach (items, id:\.self) { item in
        MercuryMenuItemView(
          item: item.title,
          icon: item.icon,
          left: .iconLabel,
          rightView: {
            Asset.Images.arrowRightNoShaftGray.image
          }
        ) {
          onTapItem(item: item)
        }
      }
      Spacer()
      
    } //: VStack
    .alert(error: $error)
    .task {
      if hasFetched { return }
      hasFetched = true
      do {
        try await modelData.fetchProfile()
      } catch {
        self.error = error
      }
    }
  }
  
  private func onTapItem(item: MyPageItemType) {
    switch item {
    case .recentlySales:
      coordinator.push(.mypage(MyPageRoute(route: .recentlySales)))
    case .chat:
      EmptyView()
      // Mail 연결
    }
  }
}
