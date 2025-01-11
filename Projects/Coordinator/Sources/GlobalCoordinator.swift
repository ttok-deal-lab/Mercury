import SwiftUI

public class GlobalCoordinator<Route: Hashable>: ObservableObject {
  @Published public var routePath = RoutePath<Route>()
  
  public init() {}
  
  public func push(_ route: Route) {
    routePath.push(route)
  }
  
  public func pop() {
    routePath.pop()
  }
  
  public func presentFullScreen(_ route: Route) {
    routePath.presentFullScreen(route)
  }
  
  public func dismissFullScreen() {
    routePath.dismissFullScreen()
  }
  
  public func popToRoot() {
    routePath.popToRoot()
  }
}

// MARK: - RoutePath

public struct RoutePath<Route: Hashable> {
  public var navigationPath = NavigationPath()
  
  public var isFullScreenPresented = false
  public var fullScreenRoute: Route? = nil
  public var fullScreenNavigationPath = NavigationPath() {
    didSet {
      print("count ~> \(fullScreenNavigationPath.count)")
    }
  }
  
  public init() {}
}

// MARK: - Common Push/Pop

extension RoutePath {
  public mutating func push(_ route: Route) {
    if isFullScreenPresented {
      pushInFullScreen(route)
      return
    }
    navigationPath.append(route)
  }
  
  public mutating func pop() {
    isFullScreenPresented ? handleFullScreenPop() : handleStandardPop()
  }
  
  private mutating func handleFullScreenPop() {
    if fullScreenNavigationPath.count == 1 {
      dismissFullScreen()
    } else {
      popInFullScreen()
    }
  }
  
  private mutating func handleStandardPop() {
    guard !navigationPath.isEmpty else { return }
    navigationPath.removeLast()
  }
}

// MARK: - FullScreen Present/Dismiss

extension RoutePath {
  public mutating func presentFullScreen(_ route: Route) {
    guard !isFullScreenPresented else { return }
    isFullScreenPresented = true
    
    fullScreenRoute = route
  }
  
  public mutating func dismissFullScreen() {
    guard isFullScreenPresented else { return }
    isFullScreenPresented = false
    fullScreenNavigationPath = .init()
    
    fullScreenRoute = nil
  }

  fileprivate mutating func pushInFullScreen(_ route: Route) {
    fullScreenNavigationPath.append(route)
  }
  
  fileprivate mutating func popInFullScreen() {
    if fullScreenNavigationPath.isEmpty {
      dismissFullScreen()
      return
    }
    fullScreenNavigationPath.removeLast()
  }
  
  fileprivate mutating func popToRoot() {
    if isFullScreenPresented {
      dismissFullScreen()
    }
    navigationPath = .init()
  }
}
