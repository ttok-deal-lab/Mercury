//
//  MainTabbarView.swift
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

enum Tab {
  case home
  case settings
}

public struct MainTabbarView<ProfileView: ProfileViewable>: View {
  @State private var selection: Tab = .home
  private var navigationSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
  public init(navigationSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    self.navigationSubject = navigationSubject
  }
  public var body: some View {
    TabView(selection: $selection) {
      ProfileView(navigationSubject: navigationSubject)
        .tabItem {
          Label("홈", systemImage: "house")
        }
        .tag(Tab.home)
      
      EmptyView()
        .tabItem {
          Label("설정", systemImage: "gear")
        }
        .tag(Tab.settings)
    }
  }
}
