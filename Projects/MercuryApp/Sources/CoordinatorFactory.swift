//
//  CoordinatorFactory.swift
//  MercuryApp
//
//  Created by 송하민 on 10/5/24.
//

import Foundation
import SwiftUI

import AppFoundation
import Coordinator
import Map
import Tutorial
import Auction

struct CoordinatorFactory: View {
  
  @EnvironmentObject var coordinator: CoordinatorManager
  
  let page: AppPage
  
  var body: some View {
    build(page: page)
  }
  
  @ViewBuilder
  func build(page: AppPage) -> some View {
    switch page {
    case .tutorial(let tutorials):
      switch tutorials {
      case .tutorialIntro:
        TutorialIntroView()
          .environmentObject(coordinator)
      case .tutorialSelectionCategory:
        TutorialSelectionCategoryView()
          .environmentObject(coordinator)
      case .tutorialSelectionRegion:
        TutorialSelectionRegionView()
          .environmentObject(coordinator)
      }
    case .auction(let auctions):
      switch auctions {
      case .recommendAuction:
        AuctionDetailView() // 추후 매물ID 박아서 진행
      }
    case .map:
      MapContentView()
        .environmentObject(coordinator)
    }
  }
}
