//
//  MainTabView.swift
//  Tabbar
//
//  Created by 송하민 on 4/13/25.
//

import Foundation
import SwiftUI
import Combine
import UIKit

import AppFoundation
import UIComponent
import Router
import Domain

public struct MainTabView<
  AuctionHomeView: AuctionHomeViewable,
  InterestView: InterestViewable,
  MyPageView: MyPageViewable,
  SignInView: SignInViewable
>: View {
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  @State private var modelData: MainTabModelData
  @State private var selection: Tab = .home
  @Inject private var toast: Toastable
  
  
  // MARK: - life cycle
  
  public init(
    localStorageUsecase: LocalStorageUsecasable
  ) {
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
              modelData.isTabEnterFirst = false
              coordinator.presentFullScreen(.onboard(OnboardRoute(route: .permissionRequest)))
            }
          }
          .task {
            // 콜드스타트/로그인 후 보류돼 있던 딥링크(예: 카카오 공유 진입)를 소비한다.
            guard let link = coordinator.pendingDeepLink else { return }
            coordinator.pendingDeepLink = nil
            try? await Task.sleep(nanoseconds: 400_000_000) // NavigationStack 등장 안정화
            coordinator.route(link)
          }
      }
    }
  }

  // MARK: - private method

  private func tab(for appTab: AppTab) -> Tab {
    switch appTab {
    case .home: return .home
    case .favorite: return .interest
    case .mypage: return .setting
    }
  }

  private func tabView() -> some View {
    TabView(selection: $selection) {
      AuctionHomeView()
        .tabItem {
          Tab.home.iconView(isSelected: selection == .home)
        }
        .tag(Tab.home)
      
      InterestView()
        .tabItem {
          Tab.interest.iconView(isSelected: selection == .interest)
        }
        .tag(Tab.interest)
      
      MyPageView()
        .tabItem {
          Tab.setting.iconView(isSelected: selection == .setting)
        }
        .tag(Tab.setting)
    }
    .background(TabBarAppearanceConfigurator())
    .toolbarVisibility(.visible, for: .tabBar)
    .toolbarBackground(.visible, for: .tabBar)
    .toolbarBackground(.ultraThinMaterial, for: .tabBar)
    .onChange(of: coordinator.selectedTab) { _, newTab in
      guard let newTab else { return }
      selection = tab(for: newTab)
      coordinator.selectedTab = nil
    }
  }
}

private struct TabBarAppearanceConfigurator: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> UIViewController {
    let viewController = UIViewController()
    viewController.view.isHidden = true
    viewController.view.isUserInteractionEnabled = false
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    DispatchQueue.main.async {
      guard let tabBar = uiViewController.tabBarController?.tabBar else { return }
      let appearance = UITabBarAppearance()
      appearance.configureWithDefaultBackground()
      appearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterial)
      appearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.9)
      appearance.shadowColor = UIColor.separator.withAlphaComponent(0.18)
      tabBar.standardAppearance = appearance
      tabBar.scrollEdgeAppearance = appearance
      tabBar.isTranslucent = true
      tabBar.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.6)
    }
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
