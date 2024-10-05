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

enum CoordinatorViewFactory {
  
  @ViewBuilder
  static func build(page: AppPage) -> some View {
    switch page {
    case .tutorialIntro:
      TutorialIntroView()
    case .tutorialSelectionCategory:
      TutorialSelectionCategoryView()
    case .tutorialSelectionRegion:
      TutorialSelectionRegionView()
    case .map:
      MapContentView()
    }
  }
}
