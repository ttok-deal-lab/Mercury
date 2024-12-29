//
//  Factory.swift
//  Tutorial
//
//  Created by 송하민 on 12/23/24.
//

import Foundation
import SwiftUI

import Coordinator

public struct TutorialFactory {
  
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


