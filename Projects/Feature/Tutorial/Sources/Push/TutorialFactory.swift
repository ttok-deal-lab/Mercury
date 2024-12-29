//
//  Factory.swift
//  Tutorial
//
//  Created by 송하민 on 12/23/24.
//

import Foundation
import SwiftUI

struct TutorialFactory {
  @Binding var path: NavigationPath
  
  init(path: Binding<NavigationPath>) {
    self._path = path
  }
  
  @ViewBuilder
  func makeView(_ tutorialRoute: TutorialRoute) -> some View {
    switch tutorialRoute.route {
    case .intro:
      TutorialIntroView(path: $path)
    case .category:
      TutorialSelectionCategoryView(path: $path)
    case .region:
      TutorialSelectionRegionView(path: $path)
    }
  }
}


