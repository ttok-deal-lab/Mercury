//
//  TabbarViewWrapperView.swift
//  MercuryApp
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import Router
import Tabbar

public struct TabbarViewWrapperView: View, TabbarViewable {
  
  let hostView: MainTabbarView<AuctionHomeViewWrapperView, InterestViewWrapperView, ReportViewWrapperView, MyPageViewWrapperView>
  
  public init(navigationSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    hostView = MainTabbarView(navigationSubject: navigationSubject)
  }
  
  public var body: some View {
    hostView
  }
}
