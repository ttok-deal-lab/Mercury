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

public struct TutorialSelectionCategoryView: View {
  
  @Environment(\.modelContext) var modelContext
  @Query var filters: [Filter]
  @EnvironmentObject private var coordinator: CoordinatorManager
  
  public init() { }

  private let colums: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
  
  public var body: some View {
    VStack {
      ScrollView {
        LazyVGrid(columns: colums) {
          ForEach(AuctionCategory.allCases) { category in
            TutorialSelectionCategoryToggleView(
              isSelected: findNonSeleted(category: category),
              category: category
            )
          }
        }
        .padding()
      }
      Spacer()
      MQButton(title: "다음") {
        coordinator.pushOnFullScreenCover(page: .tutorial(.tutorialSelectionRegion))
      }
    }
    .navigationTitle("선호 물건을 선택하세요")
  }
  
  private func findNonSeleted(category: AuctionCategory) -> Bool {
    guard let filter = filters.first else { return false }
    
    return filter.favoriteCategories.contains(where: { $0 == category.rawValue })
  }
}



#Preview {
  NavigationStack {
    TutorialSelectionCategoryView()
      .border(.brown)
      .navigationTitle("경매 카테고리")
  }
  
}
