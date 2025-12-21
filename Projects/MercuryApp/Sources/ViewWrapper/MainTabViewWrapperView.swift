//
//  MainTabViewWrapperView.swift
//  MercuryApp
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import Router
import MainTab
import Domain

public struct MainTabViewWrapperView: View, MainTabViewable {
  
  let hostView: MainTabView<
    AuctionHomeViewWrapperView,
    InterestViewWrapperView,
    ReportViewWrapperView,
    MyPageViewWrapperView,
    SignInViewWrapperView
  >
  
  public init(
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>,
    localStorageUsecase: LocalStorageUsecasable,
    auctionListUsecase: AuctionSalesListUsecasable,
    auctionSearchFilterUsecase: AuctionSearchFilterUsecasable,
    userProfileUsecase: MyPageUsecasable
  ) {
    hostView = MainTabView(
      navigationStream: navigationStream,
      localStorageUsecase: localStorageUsecase,
      auctionListUsecase: auctionListUsecase
    )
  }
  
  public var body: some View {
    hostView
  }
}
