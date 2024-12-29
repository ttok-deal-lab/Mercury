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

struct AppFactoryAggregator: ViewFactory {
  
  @ViewBuilder
  func makeView(_ route: GlobalRoute) -> some View {
    switch route {
    case .tutorial(let tutorialRoute):
      TutorialFactory.makeView(tutorialRoute)
    case .auction(let auctionRoute):
      AuctionFactory.makeView(auctionRoute)
    }
  }
}
