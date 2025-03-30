//
//  AppRouteFactory.swift
//  MercuryApp
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI
import Coordinator

import Tutorial
import Auction
import SignIn
import Infrastructure
import Domain

struct AppFactoryAggregator: ViewFactory {
  @ViewBuilder
  func makeView(_ route: GlobalRoute) -> some View {
    switch route {
    case .signIn(let signInRoute):
      SignInViewFactory(
        serviceSignInUsecasable: ServiceSignInUsecase(repository: ServiceSignInRepository()),
        localStorageUsecasable: LocalStorageUsecase(localStorageRepositorable: UserDefaultsStoreRepository())
      ).makeView(signInRoute)
    case .tutorial(let tutorialRoute):
      TutorialViewFactory.makeView(tutorialRoute)
    case .auction(let auctionRoute):
      AuctionViewFactory.makeView(auctionRoute)
    @unknown default:
      fatalError()
    }
  }
}
