//
//  ViewFactory.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI

public protocol ViewFactory {
  associatedtype RouteType
  associatedtype ViewType: View
  
  @ViewBuilder
  func makeView(_ route: RouteType) -> ViewType
}
