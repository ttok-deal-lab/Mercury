//
//  NavigationCoordinator+DeepLink.swift
//  Router
//
//  Created by DevLifter on 7/6/26.
//

import Foundation

public extension NavigationCoordinator where Route == FeatureRoute {
  /// 딥링크를 실제 내비게이션으로 실행한다.
  func route(_ deepLink: DeepLink) {
    switch deepLink {
    case .auctionDetail(let id):
      push(.auctionDetail(AuctionDetailRoute(route: .auctionDetail(auctionID: id))))

    case .search(let keyword):
      push(.search(SearchRoute(route: .searchResult(keyword: keyword))))

    case .tab(let tab):
      popToRoot()
      selectTab(tab)
    }
  }
}
