//
//  MyPageViewFactory.swift
//  MyPage
//
//  Created by 최수훈 on 11/16/25.
//

import Foundation
import SwiftUI
import Combine

import Domain
import Router

public struct RecentViewListViewFactory: ViewFactory {
  
  private let recentViewListUsecase: RecentViewListUsecase
  
  public init(
    recentViewListUsecase: RecentViewListUsecase
  ) {
    self.recentViewListUsecase = recentViewListUsecase
  }
  
  public func makeView(
    _ mypageRouter: RecentViewRoute
  ) -> some View {
    switch mypageRouter.route {
    case .recentViewedList:
      RecentSalesView(
        recentViewListUsecase: recentViewListUsecase
      )
    }
  }
}
