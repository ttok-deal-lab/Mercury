//
//  AppCoordinatorView.swift
//  MercuryApp
//
//  Created by 송하민 on 8/30/24.
//


import SwiftUI
import Foundation
import SwiftData

import Map
import Tutorial
import Auction
import AppFoundation
import Coordinator

struct AppView: View {
  
  @EnvironmentObject var coordinator: CoordinatorManager
  @Environment(\.modelContext) var modelContext
  @Query var filters: [Filter]
  @AppStorage(UserDefaultsKeyDefine.isAppFirst.rawValue) var isAppFirst: Bool = true
  
  var body: some View {
    
    NavigationStack(path: $coordinator.path) {
      CoordinatorFactory(page: rootPage())
        .navigationDestination(for: AppPage.self) { page in
          CoordinatorFactory(page: page)
        }
        .sheet(item: $coordinator.sheet) { page in
          CoordinatorFactory(page: page)
        }
        .fullScreenCover(item: $coordinator.fullScreenCover) { page in
          NavigationStack(path: $coordinator.fullScreenCoverPath) {
            CoordinatorFactory(page: page)
              .navigationDestination(for: AppPage.self) { page in
                CoordinatorFactory(page: page)
              }
          }
        }
    }
    .onAppear {
      if filters.isEmpty {
        let newFilter = Filter()
        modelContext.insert(newFilter)
        
        do {
          try modelContext.save()
          print("컨텍스트 생성 완료")
        } catch {
          print("컨텍스트 생성 실패")
        }
      }
    }
  }
  
  private func rootPage() -> AppPage {
    guard let root = coordinator.rootPage else {
      return isAppFirst ? .tutorial(.tutorialIntro) : .map
    }
    return root
  }
  
}

#Preview {
  AppView()

}

