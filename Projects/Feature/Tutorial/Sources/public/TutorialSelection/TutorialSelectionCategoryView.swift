//
//  TutorialSelectionViewStep1.swift
//  Tutorial
//
//  Created by 송하민 on 10/5/24.
//

import SwiftUI
import Foundation

import AppFoundation
import Coordinator
import UIComponent


public struct TutorialSelectionCategoryView: View {
  
  @ObservedObject private var coordinator: CoordinatorManager
  private let colums: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
  
  public init(coordinator: CoordinatorManager) {
    self.coordinator = coordinator
  }
  
  public var body: some View {
    VStack {
      ScrollView {
        LazyVGrid(columns: colums) {
          ForEach(AuctionCategories.allCases) { category in
            TutorialSelectionCategoryToggleView(categoryImage: category.selectionImage, categoryName: category.rawValue)
          }
        }
        
        .padding()
      }
      Spacer()
      MQButton(title: "다음") {
//        coordinator.push(page: .tutorial(.tutorialSelectionRegion))
        coordinator.pushOnFullScreenCover(page: .tutorial(.tutorialSelectionRegion))
      }
    }
    .navigationTitle("경매 카테고리")
  }
}

extension AuctionCategories {
  var selectionImage: Image {
    switch self {
    case .house:
      UIComponentAsset.Images.house.swiftUIImage
    case .apartment:
      UIComponentAsset.Images.apartment.swiftUIImage
    case .officetel:
      UIComponentAsset.Images.offictel.swiftUIImage
    case .land:
      UIComponentAsset.Images.land.swiftUIImage
    case .factory:
      UIComponentAsset.Images.factory.swiftUIImage
    case .store:
      UIComponentAsset.Images.store.swiftUIImage
    }
  }
}

#Preview {
  NavigationStack {
    TutorialSelectionCategoryView(coordinator: CoordinatorManager())
      .border(.brown)
      .navigationTitle("경매 카테고리")
  }
  
}
