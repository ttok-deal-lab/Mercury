//
//  CoordinateModifier.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI

public struct CoordinateModifier<Route: Hashable, Factory: ViewFactory>: ViewModifier where Factory.RouteType == Route {
  @EnvironmentObject private var coordinator: GlobalCoordinator<Route>
  
  private let factory: Factory
  
  public init(factory: Factory) {
    self.factory = factory
  }
  
  public func body(content: Content) -> some View {
    content
      .navigationDestination(for: Route.self) { route in
        if coordinator.routePath.isFullScreenPresented == false {
          factory.makeView(route)
        }
      }
      .fullScreenCover(isPresented: $coordinator.routePath.isFullScreenPresented, content: fullScreenView)
  }
  
  @ViewBuilder
  private func fullScreenView() -> some View {
    if let route = coordinator.routePath.fullScreenRoute {
      NavigationStack(path: $coordinator.routePath.fullScreenNavigationPath) {
        if coordinator.routePath.fullScreenNavigationPath.isEmpty {
          factory.makeView(route)
        } else {
          factory.makeView(route)
            .navigationDestination(for: Route.self) { route in
              factory.makeView(route)
            }
        }
      }
    }
  }
}

public extension View {
  func adjustCoordinator<Route: Hashable, Factory: ViewFactory>(factory: Factory) -> some View where Factory.RouteType == Route {
    modifier(CoordinateModifier(factory: factory))
  }
}
