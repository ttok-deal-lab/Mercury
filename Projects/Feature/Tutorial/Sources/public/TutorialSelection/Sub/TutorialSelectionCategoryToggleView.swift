//
//  TutorialSelectionCategoryToggleView.swift
//  Tutorial
//
//  Created by 송하민 on 10/6/24.
//

import SwiftUI
import SwiftData

import AppFoundation
import UIComponent

struct TutorialSelectionCategoryToggleView: View {
  
  @Environment(\.modelContext) private var modelContext
  @Query var filters: [Filter]
  @State var isSelected: Bool = false
  let category: AuctionCategory
  
  init(isSelected: Bool, category: AuctionCategory) {
    self.isSelected = isSelected
    self.category = category
  }
  
  public var body: some View {
    Button {
      isSelected.toggle()
      updateFavoriteCategories()
    } label: {
      ZStack {
        VStack {
          HStack {
            Spacer()
            MQCheckbox(type: .circle, checkColor: .black, isChecked: $isSelected)
          }
          category.selectionImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 70, height: 70)
            .padding(.top, 8)
          Text(category.rawValue)
            .font(.headline)
            .foregroundStyle(.black)
            .padding(.top, 12)
        }
      }
    }
    .padding(8)
    .overlay(
      RoundedRectangle(cornerRadius: 12)
        .stroke(isSelected ? .black : .gray, lineWidth: 1)
    )
    .clipShape(RoundedRectangle(cornerRadius: 12))
  }
  
  private func updateFavoriteCategories() {
    guard let filter = filters.first else { return }
    
    if isSelected {
      if !filter.favoriteCategories.contains(category.rawValue) {
        filter.favoriteCategories.append(category.rawValue)
      }
    } else {
      filter.favoriteCategories.removeAll { $0 == category.rawValue }
    }
    
    do {
      try modelContext.save()
      print("저장완료!")
    } catch {
      print("Failed to save favorite categories: \(error)")
    }
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

//#Preview {
//  TutorialSelectionCategoryToggleView(
//    globalFilter:
//        .constant(
//          .init()
//        ),
//    categoryImage: UIComponentAsset.Images.apartment.swiftUIImage,
//    categoryName: "아파트"
//  )
//}
