//
//  NavigationCoordinator.swift
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
  private var navigationStack: [Route] = []
  private var fullScreenStack: [Route] = []
  
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
        fullScreenStack.append(route)
        fullScreenPath.append(route)
      } else {
        navigationStack.append(route)
        navigationPath.append(route)
      }
    case .pop:
      if isFullScreenPresented {
        if fullScreenStack.isEmpty {
          isFullScreenPresented = false
          fullScreenRoute = nil
        } else {
          fullScreenStack.removeLast()
          fullScreenPath = NavigationPath(fullScreenStack)
        }
      } else if !navigationStack.isEmpty {
        navigationStack.removeLast()
        navigationPath = NavigationPath(navigationStack)
      }
    case .popToRoot:
      if isFullScreenPresented {
        fullScreenStack = []
        fullScreenPath = NavigationPath()
        isFullScreenPresented = false
        fullScreenRoute = nil
      }
      navigationStack = []
      navigationPath = NavigationPath()
    case .popTo(let route):
      if isFullScreenPresented {
        if let index = fullScreenStack.lastIndex(of: route) {
          let newStack = Array(fullScreenStack[...index])
          fullScreenStack = newStack
          fullScreenPath = NavigationPath(newStack)
        }
      } else {
        if let index = navigationStack.lastIndex(of: route) {
          let newStack = Array(navigationStack[...index])
          navigationStack = newStack
          navigationPath = NavigationPath(newStack)
        }
      }
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
