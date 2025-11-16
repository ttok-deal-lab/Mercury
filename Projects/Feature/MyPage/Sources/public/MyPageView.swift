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

enum MyPageItemType: String, CaseIterable {
  case recentlySales = "최근 본 매물"
  case chat = "1:1 문의"
}

public struct MyPageView: View {
  @State private var modelData: MyPageModelData
  @State private var error: MercuryError?
  @State private var hasFetched = false
  @Inject private var accessTokenManager: AccessTokenManagable
  private var items: [String] = MyPageItemType.allCases.map(\.rawValue)
  private var icons: [Image] = [Asset.Images.home.image, Asset.Images.chat.image]
  
  private var navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
  public init(
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>,
    userProfileUsecase: UserProfileUsecasable
  ) {
    self.navigationStream = navigationStream
    self.modelData = MyPageModelData(userProfileUsecasable: userProfileUsecase)
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      MercuryNavigationBar(
        rightButtons: {
          Button {
            navigationStream.send(.push(.setting(.init(route: .setting))))
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
          item: item,
          icon: icons[items.firstIndex(of: item) ?? 0],
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
  
  private func onTapItem(item: String) {
    guard let item = MyPageItemType(rawValue: item) else { return }
    switch item {
    case .recentlySales:
      navigationStream.send(.push(.mypage(.init(route: .recentlySales))))
    case .chat:
      EmptyView()
      // Mail 연결
    }
  }
}
