//
//  TutorialSelectionCategoryToggleView.swift
//  Tutorial
//
//  Created by 송하민 on 10/6/24.
//

import SwiftUI
import UIComponent

public struct TutorialSelectionCategoryToggleView: View {
  
  @State private var isSelected: Bool = false
  let categoryImage: Image
  let categoryName: String
  
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
          categoryImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 70, height: 70)
            .padding(.top, 8)
          Text(categoryName)
            .font(.headline)
            .foregroundStyle(.black)
            .padding(.top, 12)
        }
      }
    }
    .padding(8)
    .overlay(
      RoundedRectangle(cornerRadius: 12)
        .stroke(Color.gray, lineWidth: 1)
    )
    .clipShape(RoundedRectangle(cornerRadius: 12))
  }
}

#Preview {
  TutorialSelectionCategoryToggleView(
    categoryImage: UIComponentAsset.Images.apartment.swiftUIImage,
    categoryName: "아파트"
  )
}
