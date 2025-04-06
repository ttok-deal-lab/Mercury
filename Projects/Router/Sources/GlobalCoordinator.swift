//
//  GlobalRoute.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//
import SwiftUI
import Combine

public final class NavigationCoordinator<Route: Hashable>: ObservableObject {
  @Published public var navigationPath = NavigationPath()
  @Published public var isFullScreenPresented = false
  @Published public var fullScreenPath = NavigationPath()
  public var fullScreenRoute: Route? = nil
  
  public var eventSubject = PassthroughSubject<NavigationEvent<Route>, Never>()
  
  private var cancellables = Set<AnyCancellable>()
  
  public init() {
    eventSubject
      .sink { [weak self] event in
        self?.handle(event: event)
      }
      .store(in: &cancellables)
  }
  
  private func handle(event: NavigationEvent<Route>) {
    switch event {
    case .push(let route):
      if isFullScreenPresented {
        fullScreenPath.append(route)
      } else {
        navigationPath.append(route)
      }
    case .pop:
      if isFullScreenPresented {
        if fullScreenPath.isEmpty {
          isFullScreenPresented = false
          fullScreenRoute = nil
        } else {
          fullScreenPath.removeLast()
        }
      } else if !navigationPath.isEmpty {
        navigationPath.removeLast()
      }
    case .popToRoot:
      if isFullScreenPresented {
        isFullScreenPresented = false
        fullScreenRoute = nil
        fullScreenPath = NavigationPath()
      }
      navigationPath = NavigationPath()
    case .presentFullScreen(let route):
      guard !isFullScreenPresented else { return }
      isFullScreenPresented = true
      fullScreenRoute = route
    case .dismissFullScreen:
      guard isFullScreenPresented else { return }
      isFullScreenPresented = false
      fullScreenRoute = nil
      fullScreenPath = NavigationPath()
    }
  }
}
