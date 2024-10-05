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

struct CoordinatorFactory {
  
  @ViewBuilder
  static func build(page: AppPage, coordinator: CoordinatorManager) -> some View {
    switch page {
    case .tutorialIntro:
      TutorialIntroView(coordinator: coordinator)
    case .tutorialSelectionCategory:
      TutorialSelectionCategoryView(coordinator: coordinator)
    case .tutorialSelectionRegion:
      TutorialSelectionRegionView(coordinator: coordinator)
    case .map:
      MapContentView(coordinator: coordinator)
    }
  }
}
