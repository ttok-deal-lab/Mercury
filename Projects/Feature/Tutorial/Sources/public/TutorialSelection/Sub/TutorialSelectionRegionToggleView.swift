//
//  TutorialSelectionRegionToggleView.swift
//  Tutorial
//
//  Created by 송하민 on 10/6/24.
//

import SwiftUI

import UIComponent
import AppFoundation

struct TutorialSelectionRegionToggleView: View {
  
  @State var isSelected: Bool = false
  let region: Region
  
  var body: some View {
    Button {
      isSelected.toggle()
    } label: {
      HStack {
        Text(region.actualName)
          .font(isSelected ? .headline : .body)
          .foregroundStyle(.black)
        Spacer()
        MQCheckbox(type: .square, checkColor: .black, isChecked: $isSelected)
      }
      .padding()
      .overlay {
        RoundedRectangle(cornerRadius: 12)
          .stroke(isSelected ? .black : .gray)
      }
    }
    .frame(maxWidth: .infinity)
  }
}

#Preview {
  TutorialSelectionRegionToggleView(
    region: .seoul
  )
}
