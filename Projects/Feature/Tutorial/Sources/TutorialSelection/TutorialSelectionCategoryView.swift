//
//  TutorialSelectionViewStep1.swift
//  Tutorial
//
//  Created by 송하민 on 10/5/24.
//

import Foundation
import SwiftUI
import SwiftData

import AppFoundation
import Coordinator
import UIComponent

struct TutorialSelectionCategoryView: View {
  @EnvironmentObject private var coordinator: GlobalCoordinator<GlobalRoute>

  private let colums: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
  
  var body: some View {
    VStack {
      ScrollView {
        LazyVGrid(columns: colums) {
          ForEach(AuctionCategory.allCases) { category in
            TutorialSelectionCategoryToggleView(
              category: category
            )
          }
        }
        .padding()
      }
      Spacer()
      MQButton(title: "다음") {
        coordinator.push(.tutorial(TutorialRoute(route: .region)))
      }
    }
    .navigationTitle("선호 물건을 선택하세요")
  }
}


