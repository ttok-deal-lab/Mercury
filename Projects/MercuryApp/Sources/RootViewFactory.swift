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
      OnboardingFactory() // 여기에 뷰 추상 타입을 끌어와서 써도 되지 않을까?
        .makeView(signInStep, navigationStream: navigationStream)
    case .auction:
      EmptyView()
    case .networkConsole:
      ConsoleView()
    }
  }
}
