//
//  ViewFactory.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI
import Combine

public protocol ViewFactory {
  associatedtype NavigationContext: Hashable
  associatedtype ScreenRoute: Hashable
  associatedtype ViewType: View
  
  @ViewBuilder
  func makeView(
    _ route: ScreenRoute,
    navigationStream: PassthroughSubject<NavigationEvent<NavigationContext>, Never>
  ) -> ViewType
}
