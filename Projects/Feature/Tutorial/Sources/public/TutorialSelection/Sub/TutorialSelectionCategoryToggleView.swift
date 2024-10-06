//
//  TutorialSelectionCategoryToggleView.swift
//  Tutorial
//
//  Created by 송하민 on 10/6/24.
//

import SwiftUI

import AppFoundation
import UIComponent

public struct TutorialSelectionCategoryToggleView: View {
  
//  @Environment(\.modelContext) private var modelContext
  @State var isSelected: Bool = false
  
  let category: AuctionCategory
  
  public var body: some View {
    Button {
      isSelected.toggle()
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
