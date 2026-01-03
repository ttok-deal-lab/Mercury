//
//  AppRouteFactory.swift
//  MercuryApp
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI
import Combine

import Router
import AuctionHome
import AuctionDetail
import Onboard
import Domain
import Infrastructure
import MyPage
import Setting
import Search

import PulseUI

struct RootViewFactory: ViewFactory {
  
  @ViewBuilder
  func makeView(
    _ route: FeatureRoute
  ) -> some View {
    switch route {
    case .onboard(let signInStep):
      OnboardingFactory(
        serviceSignInUsecasable: ServiceSignInUsecase(repository: ServiceSignInRepository()),
        locationUsecasable: LocationUsecase()
      )
      .makeView(signInStep)
    case .auctionDetail(let auctionStep):
      AuctionDetailViewFactory<MapViewWrapperView>(
        auctionDetailUsecase: AuctionDetailUsecase(auctionDetailRepositorable: AuctionDetailRepository())
      )
      .makeView(auctionStep)
    case .networkConsole:
      ConsoleView()
    case .setting(let settingStep):
      SettingViewFactory()
        .makeView(settingStep)
    case .recentViewList(let myPageStep):
      RecentSalesViewFactory(
        recentViewListUsecase: RecentSalesUsecase(
          repository: RecentSalesRepository(),
          localStorageUseCase: LocalStorageUsecase(repository: UserDefaultsStoreRepository())
        )
      )
      .makeView(myPageStep)
    case .notification:
      NotificationView()
      
    case .search(let searchStep):
      SearchViewFactory(
        auctionSalesListUsecase: AuctionSalesListUsecase(repository: AuctionSalesListRepository()),
        auctionSearchFilterUsecase: AuctionSearchFilterUsecase(repository: AuctionSearchFilterRepository()),
        localStoargeUsecase: LocalStorageUsecase(repository: UserDefaultsStoreRepository())
      )
      .makeView(searchStep)
    }
  }
}
