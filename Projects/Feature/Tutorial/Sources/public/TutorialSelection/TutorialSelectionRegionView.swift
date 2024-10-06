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
  
  @Environment(\.modelContext) private var modelContext
  @ObservedObject private var coordinator: CoordinatorManager
  private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
  
  public init(coordinator: CoordinatorManager) {
    self.coordinator = coordinator
  }
  
  public var body: some View {
    VStack {
      ScrollView {
        LazyVGrid(columns: columns, spacing: 8) {
          ForEach(Region.allCases) { region in
            TutorialSelectionRegionToggleView(region: region)
          }
        }
        .padding()
      }
      Spacer()
      MQButton(title: "준비됐어요!") {
        coordinator.dismissCover()
      }
    }
  }
}

#Preview {
  NavigationStack {
    TutorialSelectionRegionView(coordinator: CoordinatorManager())
      .navigationTitle("선호 지역을 선택하세요")
  }
  
}
