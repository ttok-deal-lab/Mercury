//
//  AppCoordinatorView.swift
//  MercuryApp
//
//  Created by 송하민 on 8/30/24.
//


import SwiftUI
import Foundation

import AppFoundation
import Coordinator
import Tutorial

struct AppView: View {
  @State private var path = NavigationPath()
  
  var body: some View {
    NavigationStack(path: $path) {
      FakeHomeView(path: $path)
        .tutorialDestination(path: $path)
    }
  }
}


struct FakeHomeView: View {
  @Binding var path: NavigationPath
  
  init(path: Binding<NavigationPath>) {
    self._path = path
  }
  
  var body: some View {
    Button {
      path.append(TutorialRoute(route: .intro))
    } label: {
      Text("go tutorial")
    }
  }
}
