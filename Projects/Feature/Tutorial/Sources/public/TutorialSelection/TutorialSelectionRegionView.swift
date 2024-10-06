//
//  TutorialSelectionViewStep1.swift
//  Tutorial
//
//  Created by 송하민 on 10/5/24.
//

import SwiftUI
import Foundation
import SwiftData

import AppFoundation
import UIComponent
import Coordinator

public struct TutorialSelectionRegionView: View {

  @EnvironmentObject private var coordinator: CoordinatorManager
  @Environment(\.modelContext) var modelContext
  @Query var filters: [Filter]
  
  private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
  
  public init() {
    
  }
  
  public var body: some View {
    VStack {
      ScrollView {
        LazyVGrid(columns: columns, spacing: 8) {
          ForEach(Region.allCases) { region in
            TutorialSelectionRegionToggleView(
              isSelected: findNonSelectedRegion(region: region),
              region: region
            )
          }
        }
        .padding()
      }
      Spacer()
      MQButton(title: "준비됐어요!") {
        coordinator.dismissCover()
      }
    }
    .navigationTitle("선호 지역을 선택하세요")
  }
  
  private func findNonSelectedRegion(region: Region) -> Bool {
    guard let filter = filters.first else { return false }
    
    return filter.favoriteRegions.contains(where: { $0 == region.rawValue })
  }
}

#Preview {
  NavigationStack {
    TutorialSelectionRegionView()
      .navigationTitle("선호 지역을 선택하세요")
  }
  
}
