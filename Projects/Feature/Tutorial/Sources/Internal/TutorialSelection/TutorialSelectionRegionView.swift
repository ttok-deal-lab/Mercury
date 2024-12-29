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
  @Binding var path: NavigationPath
  private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)
  
  init(path: Binding<NavigationPath>) {
    self._path = path
  }
  
  public var body: some View {
    VStack {
      ScrollView {
        LazyVGrid(columns: columns, spacing: 8) {
          ForEach(Region.allCases) { region in
            TutorialSelectionRegionToggleView(
              region: region
            )
          }
        }
        .padding()
      }
      Spacer()
      MQButton(title: "준비됐어요!") {
//        coordinator.dismissCover()
      }
    }
    .navigationTitle("선호 지역을 선택하세요")
  }

}

#Preview {
  NavigationStack {
    TutorialSelectionRegionView(path: Binding(get: { NavigationPath() }, set: { _ in }))
      .navigationTitle("선호 지역을 선택하세요")
  }
  
}
