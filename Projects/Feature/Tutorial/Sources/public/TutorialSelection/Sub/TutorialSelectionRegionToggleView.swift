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
  
  @Environment(\.modelContext) private var modelContext
  @Query var filters: [Filter]
  @State var isSelected: Bool
  let region: Region
  
  public init(isSelected: Bool, region: Region) {
    self.isSelected = isSelected
    self.region = region
  }
  
  var body: some View {
    Button {
      isSelected.toggle()
      updateFavoriteRegions()
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
  
  private func updateFavoriteRegions() {
    guard let filter = filters.first else { return }
    
    if isSelected {
      if !filter.favoriteRegions.contains(region.rawValue) {
        filter.favoriteRegions.append(region.rawValue)
      }
    } else {
      filter.favoriteRegions.removeAll(where: { $0 == region.rawValue })
    }
    
    do {
      try modelContext.save()
    } catch {
      print("Failed to save favorite categories: \(error)")
      fatalError()
    }
  }
}

#Preview {
  TutorialSelectionRegionToggleView(
    isSelected: false,
    region: .seoul
  )
}
