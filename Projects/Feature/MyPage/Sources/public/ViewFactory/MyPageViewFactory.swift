//
//  MyPageViewFactory.swift
//  MyPage
//
//  Created by 최수훈 on 11/16/25.
//

import Foundation
import SwiftUI
import Combine

import Router

public struct MyPageViewFactory: ViewFactory {
  private let modelData: MyPageModelData
  
  public init(modelData: MyPageModelData) {
    self.modelData = modelData
  }
  
  public func makeView(
    _ mypageRouter: MyPageRoute,
    navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  ) -> some View {
    switch mypageRouter.route {
    case .recentlySales:
      RecentlySalesView(navigationStream: navigationStream)
    }
  }
}
