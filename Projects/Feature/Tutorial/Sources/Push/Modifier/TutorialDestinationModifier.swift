//
//  TutorialDestinationModifier.swift
//  Tutorial
//
//  Created by 송하민 on 12/23/24.
//

import SwiftUI

import Coordinator

public struct TutorialDestinationModifier: ViewModifier {
  @Binding var path: NavigationPath
  
  public init(path: Binding<NavigationPath>) {
    self._path = path
  }
  
  public func body(content: Content) -> some View {
    content
      .navigationDestination(for: TutorialRoute.self) { route in
        TutorialFactory(path: $path)
          .makeView(route)
      }
  }
}

public extension View {
  func tutorialDestination(path: Binding<NavigationPath>) -> some View {
    self.modifier(TutorialDestinationModifier(path: path))
  }
}
