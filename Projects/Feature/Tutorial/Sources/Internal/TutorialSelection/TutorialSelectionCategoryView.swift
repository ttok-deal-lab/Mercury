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
  @Binding var path: NavigationPath
  
  init(path: Binding<NavigationPath>) {
    self._path = path
  }

  private let colums: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
  
  public var body: some View {
    VStack {
      ScrollView {
        LazyVGrid(columns: colums) {
          ForEach(AuctionCategory.allCases) { category in
            TutorialSelectionCategoryToggleView(
              category: category
            )
          }
        }
        .padding()
      }
      Spacer()
      MQButton(title: "다음") {
        path.append(TutorialRoute(route: .region))
      }
    }
    .navigationTitle("선호 물건을 선택하세요")
  }
}



#Preview {
  NavigationStack {
    TutorialSelectionCategoryView(path: Binding(get: { NavigationPath() }, set: { _ in }))
      .border(.brown)
      .navigationTitle("경매 카테고리")
  }
  
}
