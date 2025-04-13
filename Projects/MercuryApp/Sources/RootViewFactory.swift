//
//  AppRouteFactory.swift
//  MercuryApp
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI
import Combine

import Router
import Auction
import Onboard
import Domain
import Infrastructure

struct RootViewFactory<ScreenRoute: Hashable>: ViewFactory {
  
  @ViewBuilder
  func makeView(
    _ route: FeatureRoute,
    navigationSubject: PassthroughSubject<NavigationEvent<ScreenRoute>, Never>
  ) -> some View {
    switch route {
    case .onboard(let signInRoute):
      SignInViewFactory<ScreenRoute>(
        serviceSignInUsecasable: ServiceSignInUsecase(repository: ServiceSignInRepository()),
        localStorageUsecasable: LocalStorageUsecase(localStorageRepositorable: UserDefaultsStoreRepository())
      )
      .makeView(signInRoute, navigationSubject: navigationSubject)
    case .auction(let auctionRoute):
      VStack { }
    }
  }
}
