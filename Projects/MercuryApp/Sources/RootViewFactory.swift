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
    case .auction(let auctionStep):
      AuctionViewFactory(
        auctionDetailUsecase: AuctionDetailUsecase(auctionDetailRepositorable: AuctionDetailRepository())
      )
      .makeView(auctionStep, navigationStream: navigationStream)
    case .networkConsole:
      ConsoleView()
    }
  }
}
