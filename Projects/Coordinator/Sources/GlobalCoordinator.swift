//
//  GlobalCoordinator.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI

public class GlobalCoordinator: ObservableObject {
  @Published public var routePath = RoutePath()
  
  public init() {}
  
  public func push(_ route: GlobalRoute) {
    routePath.push(route)
  }
  
  public func pop() {
    routePath.pop()
  }
  
  public func popTo(_ target: GlobalRoute) {
    routePath.popTo(target)
  }
  
  public func poptoRoot() {
    routePath.popToRoot()
  }
  
  public func presentFullScreen(_ route: GlobalRoute) {
    routePath.presentFullScreen(route)
  }
  
  public func dismissFullScreen() {
    routePath.dismissFullScreen()
  }
  
  public func pushInFullScreen(_ route: GlobalRoute) {
    routePath.pushInFullScreen(route)
  }
  
  public func popInFullScreen() {
    routePath.popInFullScreen()
  }
}

public struct RoutePath {
  public var navigationPath = NavigationPath()
  private var routeStack: [GlobalRoute] = []
  
  public var fullScreenNavigationPath = NavigationPath()
  private var fullScreenStack: [GlobalRoute] = []
  public var isFullScreenPresented = false
  public private(set) var fullScreenRoute: GlobalRoute? = nil
  
  public init() { }
}

extension RoutePath {
  public mutating func push(_ route: GlobalRoute) {
    navigationPath.append(route)
    routeStack.append(route)
  }
  
  public mutating func pop() {
    guard !routeStack.isEmpty else { return }
    routeStack.removeLast()
    navigationPath.removeLast()
  }
  
  public mutating func popTo(_ target: GlobalRoute) {
    while let last = routeStack.last, last != target {
      routeStack.removeLast()
      navigationPath.removeLast()
    }
  }
  
  public mutating func popToRoot() {
    routeStack.removeAll()
    navigationPath = NavigationPath()
  }
}

extension RoutePath {
  public mutating func presentFullScreen(_ route: GlobalRoute) {
    isFullScreenPresented = true
    fullScreenRoute = route
    fullScreenNavigationPath = NavigationPath()
    fullScreenStack.removeAll()
  }
  
  public mutating func dismissFullScreen() {
    isFullScreenPresented = false
    fullScreenRoute = nil
    fullScreenNavigationPath = NavigationPath()
    fullScreenStack.removeAll()
  }
  
  public mutating func pushInFullScreen(_ route: GlobalRoute) {
    guard isFullScreenPresented else { return }
    fullScreenNavigationPath.append(route)
    fullScreenStack.append(route)
  }
  
  public mutating func popInFullScreen() {
    guard isFullScreenPresented, !fullScreenStack.isEmpty else { return }
    fullScreenStack.removeLast()
    fullScreenNavigationPath.removeLast()
  }
  
  public mutating func popToInFullScreen(_ target: GlobalRoute) {
    guard isFullScreenPresented else { return }
    while let last = fullScreenStack.last, last != target {
      fullScreenStack.removeLast()
      fullScreenNavigationPath.removeLast()
    }
  }
  
  public mutating func popToRootInFullScreen() {
    guard isFullScreenPresented else { return }
    fullScreenStack.removeAll()
    fullScreenNavigationPath = NavigationPath()
  }
}
