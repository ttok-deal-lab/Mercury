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

public struct MyPageViewFactory: ViewFactory {
  private let mypageUsecasable: MyPageUsecasable
  
  public init(mypageUsecasable: MyPageUsecasable) {
    self.mypageUsecasable = mypageUsecasable
  }
  
  public func makeView(
    _ mypageRouter: MyPageRoute
  ) -> some View {
    switch mypageRouter.route {
    case .recentlySales:
//      RecentSalesView()
      EmptyView()
    case .chat:
      EmptyView()
    }
  }
}
