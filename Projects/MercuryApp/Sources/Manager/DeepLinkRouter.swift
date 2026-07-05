//
//  DeepLinkRouter.swift
//  MercuryApp
//
//  Created by DevLifter on 7/6/26.
//

import Foundation

import Router

/// `estateSlug://` 딥링크를 앱 내비게이션으로 연결한다.
///
/// 정책
/// - warm + 로그인 상태: 즉시 목적지로 이동한다.
/// - 콜드스타트 / 미로그인: `coordinator.pendingDeepLink` 에 보류했다가
///   `MainTabView` 가 등장(로그인 완료)할 때 소비한다. (카카오 공유 링크는 대부분 앱이 꺼진 상태에서 열림)
@MainActor
enum DeepLinkRouter {
  @discardableResult
  static func handle(
    _ url: URL,
    coordinator: NavigationCoordinator<FeatureRoute>,
    isLoggedIn: Bool
  ) -> Bool {
    guard let link = DeepLinkParser.parse(url) else {
      print("[DEEPLINK] ignored (unsupported): \(url.absoluteString)")
      return false
    }

    print("[DEEPLINK] url=\(url.absoluteString) parsed=\(link) isLoggedIn=\(isLoggedIn)")

    if isLoggedIn {
      coordinator.route(link)
    } else {
      // 콜드스타트/미로그인: 준비되면 소비하도록 보류
      coordinator.pendingDeepLink = link
      print("[DEEPLINK] deferred until app is ready")
    }
    return true
  }
}
