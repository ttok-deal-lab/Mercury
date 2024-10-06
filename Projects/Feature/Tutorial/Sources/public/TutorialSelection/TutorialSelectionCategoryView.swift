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
  @State var filter: Filter?
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
              isSelected: Binding(
                get: {
                  filter?.favoriteCategories.contains(category.rawValue) ?? false
                },
                set: { newValue in
                  if newValue {
                    filter?.favoriteCategories.append(category.rawValue)
//                    do {
//                      try modelContext.save()
//                    } catch {
//                      print("wwwW?W??????")
//                    }
                  } else {
                    filter?.favoriteCategories.removeAll { $0 == category.rawValue }
                  }
                }
              ),
              categoryImage: category.selectionImage,
              categoryName: category.rawValue
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
    .onAppear {
      self.filter = Filter.getShared(context: modelContext)
    }
    .navigationTitle("선호 물건을 선택하세요")
  }
}

extension AuctionCategory {
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
