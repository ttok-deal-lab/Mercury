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

import PulseUI

struct RootViewFactory: ViewFactory {
  
  @ViewBuilder
  func makeView(
    _ route: FeatureRoute,
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  ) -> some View {
    switch route {
    case .onboard(let signInStep):
      OnboardingFactory(
        serviceSignInUsecasable: ServiceSignInUsecase(repository: ServiceSignInRepository()),
        locationUsecasable: LocationUsecase()
      )
      .makeView(signInStep, navigationStream: navigationStream)
    case .auctionDetail(let auctionStep):
      AuctionDetailViewFactory<MapViewWrapperView>(
        auctionDetailUsecase: AuctionDetailUsecase(auctionDetailRepositorable: AuctionDetailRepository())
      )
      .makeView(auctionStep, navigationStream: navigationStream)
    case .networkConsole:
      ConsoleView()
    case .setting(let settingStep):
      SettingViewFactory()
        .makeView(settingStep, navigationStream: navigationStream)
    case .terms(let agreementStep):
      TermsViewFactory()
        .makeView(agreementStep, navigationStream: navigationStream)
    case .mypage(let myPageStep):
      MyPageViewFactory(
        mypageUsecasable: MyPageUsecase(repository: MyPageRepository())
      )
      .makeView(myPageStep, navigationStream: navigationStream)
    }
  }
}
