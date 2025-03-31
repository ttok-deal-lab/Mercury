//
//  Factory.swift
//  Tutorial
//
//  Created by 송하민 on 12/23/24.
//

import Foundation
import SwiftUI

import Router

public struct TutorialViewFactory {
  @ViewBuilder
  public static func makeView(_ tutorialRoute: TutorialRoute) -> some View {
    switch tutorialRoute.route {
    case .intro:
      TutorialIntroView()
    case .category:
      TutorialSelectionCategoryView()
    case .region:
      TutorialSelectionRegionView()
    }
  }
}


