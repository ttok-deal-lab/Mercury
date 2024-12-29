//
//  TutorialSelectionRegionToggleView.swift
//  Tutorial
//
//  Created by 송하민 on 10/6/24.
//

import SwiftUI
import SwiftData

import UIComponent
import AppFoundation

struct TutorialSelectionRegionToggleView: View {
  @State var isSelected: Bool = false
  let region: Region
  
  public init(region: Region) {
    self.region = region
  }
  
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
