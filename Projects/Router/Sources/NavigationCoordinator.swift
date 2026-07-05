//
//  NavigationCoordinator.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//
import SwiftUI
import Combine

@MainActor
public final class NavigationCoordinator<Route: Hashable>: ObservableObject {

  @Published public var rootStack: [Route] = []
  @Published public var isFullScreenPresented: Bool = false
  @Published public var fullScreenRoute: Route? = nil
  @Published public var fullScreenStack: [Route] = []

  /// 딥링크 등으로 탭을 전환할 때 사용. `MainTabView` 가 이 값을 관찰해 선택 탭을 갱신한다.
  @Published public var selectedTab: AppTab? = nil

  /// 콜드스타트/미로그인 시점에 도착한 딥링크를 보류한다. 앱이 준비되면(`MainTabView` 등장) 소비한다.
  @Published public var pendingDeepLink: DeepLink? = nil

  private let eventSubject = PassthroughSubject<NavigationEvent<Route>, Never>()
  private var cancellables = Set<AnyCancellable>()

  public init() {
    eventSubject
      .receive(on: DispatchQueue.main)
      .sink { [weak self] event in
        self?.handle(event: event)
      }
      .store(in: &cancellables)
  }

  // MARK: - Public Navigation API
  
  public func push(_ route: Route) { eventSubject.send(.push(route)) }
  public func pop() { eventSubject.send(.pop) }
  public func popToRoot() { eventSubject.send(.popToRoot) }
  public func popTo(_ route: Route) { eventSubject.send(.popTo(route)) }
  public func presentFullScreen(_ route: Route) { eventSubject.send(.presentFullScreen(route)) }
  public func dismissFullScreen() { eventSubject.send(.dismissFullScreen) }
  public func selectTab(_ tab: AppTab) { selectedTab = tab }

  // MARK: - Internal
  
  private func handle(event: NavigationEvent<Route>) {
    switch event {
    case .push(let route):
      if isFullScreenPresented {
        fullScreenStack.append(route)
      } else {
        rootStack.append(route)
      }

    case .pop:
      if isFullScreenPresented {
        if !fullScreenStack.isEmpty {
          _ = fullScreenStack.popLast()
        } else {
          // 정책: 풀스크린 루트에서 pop이면 닫기
          isFullScreenPresented = false
          fullScreenRoute = nil
          fullScreenStack.removeAll()
        }
      } else {
        _ = rootStack.popLast()
      }

    case .popToRoot:
      if isFullScreenPresented {
        fullScreenStack.removeAll()
        isFullScreenPresented = false
        fullScreenRoute = nil
      }
      rootStack.removeAll()

    case .popTo(let route):
      if isFullScreenPresented {
        if let idx = fullScreenStack.lastIndex(of: route) {
          fullScreenStack = Array(fullScreenStack.prefix(idx + 1))
        }
      } else {
        if let idx = rootStack.lastIndex(of: route) {
          rootStack = Array(rootStack.prefix(idx + 1))
        }
      }

    case .presentFullScreen(let route):
      guard !isFullScreenPresented else { return }
      isFullScreenPresented = true
      fullScreenRoute = route
      fullScreenStack.removeAll()

    case .dismissFullScreen:
      guard isFullScreenPresented else { return }
      isFullScreenPresented = false
      fullScreenRoute = nil
      fullScreenStack.removeAll()
    }
  }
}
