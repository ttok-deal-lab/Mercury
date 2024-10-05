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

struct CoordinatorFactory {
  
  @ViewBuilder
  static func build(page: AppPage, coordinator: CoordinatorManager) -> some View {
    switch page {
    case .tutorial(let tutorials):
      switch tutorials {
      case .tutorialIntro:
        TutorialIntroView(coordinator: coordinator)
      case .tutorialSelectionCategory:
        TutorialSelectionCategoryView(coordinator: coordinator)
      case .tutorialSelectionRegion:
        TutorialSelectionRegionView(coordinator: coordinator)
      }
    case .auction(let auctions):
      switch auctions {
      case .recommendAuction:
        AuctionDetailView() // 추후 매물ID 박아서 진행
      }
    case .map:
      MapContentView(coordinator: coordinator)
    }
  }
}
