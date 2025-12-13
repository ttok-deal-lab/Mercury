//
//  MainTabView.swift
//  Tabbar
//
//  Created by 송하민 on 4/13/25.
//

import Foundation
import SwiftUI
import Combine

import AppFoundation
import UIComponent
import Router
import Domain

public struct MainTabView<
  AuctionHomeView: AuctionHomeViewable,
  InterestView: InterestViewable,
  ReportView: ReportViewable,
  MyPageView: MyPageViewable,
  SignInView: SignInViewable
>: View {
  @Environment(NetworkMonitor.self) var networkMonitor
  @State private var isShowNetworkDisconnect: Bool = false
  @State private var modelData: MainTabModelData
  @State private var selection: Tab = .home
  @Inject private var toast: Toastable
  
  private var navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  private let auctionListUsecase: AuctionSalesListUsecasable
  
  // MARK: - life cycle
  
  public init(
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>,
    localStorageUsecase: LocalStorageUsecasable,
    auctionListUsecase: AuctionSalesListUsecasable
  ) {
    self.navigationStream = navigationStream
    self.auctionListUsecase = auctionListUsecase
    self.modelData = MainTabModelData(localStorageUsecase: localStorageUsecase)
  }
  
  public var body: some View {
    ZStack {
      if !modelData.isUserLoggedIn {
        SignInView(onComplete: nil)
      } else {
        tabView()
          .task {
            if modelData.isTabEnterFirst {
              navigationStream.send(.presentFullScreen(.onboard(.init(route: .permissionRequest))))
            }
          }
      }
    }
  }
  
  // MARK: - private method
  
  private func tabView() -> some View {
    TabView(selection: $selection) {
      AuctionHomeView(
        navigationStream: navigationStream,
        auctionListUsecase: auctionListUsecase
      )
      .tabItem {
        Tab.home.iconView(isSelected: selection == .home)
      }
      .tag(Tab.home)
      
      InterestView(navigationStream: navigationStream)
        .tabItem {
          Tab.interest.iconView(isSelected: selection == .interest)
        }
        .tag(Tab.interest)
      
      MyPageView(navigationStream: navigationStream)
        .tabItem {
          Tab.setting.iconView(isSelected: selection == .setting)
        }
        .tag(Tab.setting)
    }
    .onAppear {
      let tabBarAppearance = UITabBarAppearance()
      tabBarAppearance.configureWithDefaultBackground()
      UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
    .onChange(of: networkMonitor.isConnected) { _, isConnected in
      isShowNetworkDisconnect = !isConnected
    }
    .sheet(isPresented: $isShowNetworkDisconnect, content: {
      VStack { // TODO: 디자인 필요
        Text("인터넷 연결이 되지 않아요")
          .fonts(.titleMediumBold)
          .padding(.vertical, 18)
        Text("인터넷 상태를 확인해주세요")
          .fonts(.bodyLargeMedium)
        Text("인터넷 연결이 되면 바로 사용할 수 있어요")
          .fonts(.bodyLargeMedium)
          .padding(.vertical, 18)
      }
      .dynamicSheet()
    })
  }
}

enum Tab {
  case home, interest, setting
  
  var title: String {
    switch self {
    case .home: return L10n.tabHome
    case .interest: return L10n.tabInterest
    case .setting: return L10n.tabSetting
    }
  }
  
  func iconImage(isSelected: Bool) -> Image {
    switch self {
    case .home: return isSelected ? Asset.Images.gnbHome.image : Asset.Images.gnbHomeGray.image
    case .interest: return isSelected ? Asset.Images.gnbInterest.image : Asset.Images.gnbInterestGray.image
    case .setting: return isSelected ? Asset.Images.gnbMypage.image : Asset.Images.gnbMypageGray.image
    }
  }
  
  func textColor(isSelected: Bool) -> Color {
    isSelected ? Asset.Colors.primary200TextSuccess.color : Asset.Colors.neutralSubtler.color
  }
  
  func iconView(isSelected: Bool) -> some View {
    VStack(spacing: .zero) {
      iconImage(isSelected: isSelected)
      Text(title)
        .fonts(.bodyMicroMedium)
        .foregroundStyle(textColor(isSelected: isSelected))
    }
  }
}
