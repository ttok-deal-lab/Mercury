//
//  AppRouteFactory.swift
//  MercuryApp
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI
import Combine

import Auction
import MyPage
import Onboard
import Domain
import Infrastructure
import Router

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
        modelData: OnboardingModelData(
          serviceSignInUsecasable: ServiceSignInUsecase(
            repository: ServiceSignInRepository()
          ),
          locationUsecasable: LocationUsecase()
        )
      )
      .makeView(signInStep, navigationStream: navigationStream)
    case .auction:
      EmptyView()
    case .networkConsole:
      ConsoleView()
    case .setting(let settingStep):
      SettingViewFactory(
        modelData: MyPageModelData(
          userProfileUsecasable: UserProfileUsecase(
            repository: UserProfileRepository()
          )
        )
      ).makeView(settingStep, navigationStream: navigationStream)
    case .terms(let agreementStep):
      TermsViewFactory(
        modelData: MyPageModelData(
          userProfileUsecasable: UserProfileUsecase(repository: UserProfileRepository())
        )
      ).makeView(agreementStep, navigationStream: navigationStream)
    case .mypage(let myPageStep):
      MyPageViewFactory(
        modelData: MyPageModelData(
          userProfileUsecasable: UserProfileUsecase(repository: UserProfileRepository())
        )
      ).makeView(myPageStep, navigationStream: navigationStream)
    }
  }
}
