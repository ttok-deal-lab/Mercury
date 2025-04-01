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
import SignIn
import Domain
import Infrastructure

struct RootViewFactory<ScreenRoute: Hashable>: ViewFactory {
  
  @ViewBuilder
  func makeView(
    _ route: GlobalRoute,
    eventSubject: PassthroughSubject<NavigationEvent<ScreenRoute>, Never>
  ) -> some View {
    switch route {
    case .signIn(let signInRoute):
      SignInViewFactory<ScreenRoute>(
        serviceSignInUsecasable: ServiceSignInUsecase(repository: ServiceSignInRepository()),
        localStorageUsecasable: LocalStorageUsecase(localStorageRepositorable: UserDefaultsStoreRepository())
      )
      .makeView(signInRoute, eventSubject: eventSubject)
    case .auction(let auctionRoute):
      VStack { }
    }
  }
}
