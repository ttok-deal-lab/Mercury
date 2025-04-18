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

struct RootViewFactory: ViewFactory {
  
  @ViewBuilder
  func makeView(
    _ route: FeatureRoute,
    navigationSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  ) -> some View {
    switch route {
    case .onboard(let signInStep):
      SignInViewFactory(
        serviceSignInUsecasable: ServiceSignInUsecase(repository: ServiceSignInRepository()),
        localStorageUsecasable: LocalStorageUsecase(localStorageRepositorable: UserDefaultsStoreRepository())
      )
      .makeView(signInStep, navigationSubject: navigationSubject)
    case .auction(let auctionStep):
      VStack { }
    }
  }
}
