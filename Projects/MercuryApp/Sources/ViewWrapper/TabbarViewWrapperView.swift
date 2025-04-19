//
//  TabbarViewWrapperView.swift
//  MercuryApp
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import Router
import MainTab

public struct TabbarViewWrapperView: View, MainTabViewable {
  
  let hostView: MainTabView<AuctionHomeViewWrapperView, InterestViewWrapperView, ReportViewWrapperView, MyPageViewWrapperView, SignInViewWrapperView>
  
  public init(navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    hostView = MainTabView(navigationStream: navigationStream)
  }
  
  public var body: some View {
    hostView
  }
}
