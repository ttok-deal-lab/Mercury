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

public struct MainTabView<
  AuctionHomeView: AuctionHomeViewable,
  InterestView: InterestViewable,
  ReportView: ReportViewable,
  MyPageView: MyPageViewable,
  SignInView: SignInViewable
>: View {
  @StateObject private var modelData = MainTabModelData()
  @State private var selection: Tab = .home
  @Inject private var toast: Toastable
  
  private var navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
  // MARK: - life cycle
  
  public init(navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    self.navigationStream = navigationStream
  }
  
  public var body: some View {
    ZStack {
      if !modelData.isUserLoggedIn {
        SignInView(onComplete: nil)
      } else {
        tabView()
      }
    }
  }
  
  // MARK: - private method
  
  private func tabView() -> some View {
    TabView(selection: $selection) {
      AuctionHomeView(navigationStream: navigationStream)
        .tabItem {
          Tab.home.iconView(isSelected: selection == .home)
        }
        .tag(Tab.home)
      
      InterestView(navigationStream: navigationStream)
        .tabItem {
          Tab.interest.iconView(isSelected: selection == .interest)
        }
        .tag(Tab.interest)
      
      ReportView(navigationStream: navigationStream)
        .tabItem {
          Tab.report.iconView(isSelected: selection == .report)
        }
        .tag(Tab.report)
      
      MyPageView(navigationStream: navigationStream)
        .tabItem {
          Tab.myPage.iconView(isSelected: selection == .myPage)
        }
        .tag(Tab.myPage)
    }
  }
}

enum Tab {
  case home, interest, report, myPage
  
  var title: String {
    switch self {
    case .home: return "홈"
    case .interest: return "관심"
    case .report: return "임장보고서"
    case .myPage: return "설정"
    }
  }
  
  func iconImage(isSelected: Bool) -> Image {
    switch self {
    case .home: return isSelected ? Asset.Images.gnbHome.image : Asset.Images.gnbHomeGray.image
    case .interest: return isSelected ? Asset.Images.gnbInterest.image : Asset.Images.gnbInterestGray.image
    case .report: return isSelected ? Asset.Images.gnbReport.image : Asset.Images.gnbReportGray.image
    case .myPage: return isSelected ? Asset.Images.gnbMypage.image : Asset.Images.gnbMypageGray.image
    }
  }
  
  func textColor(isSelected: Bool) -> Color {
    isSelected ? Asset.Colors.primary200TextSuccess.color : Asset.Colors.gray400TextSubText.color
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
