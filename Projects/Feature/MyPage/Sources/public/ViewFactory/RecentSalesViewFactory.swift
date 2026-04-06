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

public struct RecentSalesViewFactory: ViewFactory {
  
  private let recentSalesUescase: RecentSalesUsecase
  private let auctionInterestUsecase: AuctionInterestUsecase
  
  public init(
    recentViewListUsecase: RecentSalesUsecase,
    auctionInterestUsecase: AuctionInterestUsecase
  ) {
    self.recentSalesUescase = recentViewListUsecase
    self.auctionInterestUsecase = auctionInterestUsecase
  }
  
  public func makeView(
    _ mypageRouter: RecentViewRoute
  ) -> some View {
    switch mypageRouter.route {
    case .recentViewedList:
      RecentSalesView(
        recentSalesUsecase: recentSalesUescase,
        auctionInterestUsecase: auctionInterestUsecase
      )
    }
  }
}
