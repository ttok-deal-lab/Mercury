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
  
//  @Environment(\.modelContext) var modelContext
  @StateObject var filter: Filter = Filter()
  @ObservedObject private var coordinator: CoordinatorManager

  private let colums: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
  
  public init(coordinator: CoordinatorManager) {
    self.coordinator = coordinator
  }
  
  public var body: some View {
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
        coordinator.pushOnFullScreenCover(page: .tutorial(.tutorialSelectionRegion))
      }
    }
//    .onAppear {
//      self.filter = Filter.getShared(context: modelContext)
//    }
    .navigationTitle("선호 물건을 선택하세요")
  }
}



#Preview {
  NavigationStack {
    TutorialSelectionCategoryView(coordinator: CoordinatorManager())
      .border(.brown)
      .navigationTitle("경매 카테고리")
  }
  
}
