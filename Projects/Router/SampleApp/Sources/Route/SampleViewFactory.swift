//
//  SampleViewFactory.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI
import Combine

import Router

struct SampleViewFactory: ViewFactory {
  
  func makeView(_ route: SampleRoute, navigationStream: PassthroughSubject<NavigationEvent<SampleRoute>, Never>) -> some View {
    switch route {
    case .a:
      AView(coordinator: navigationStream)
    case .b:
      BView(coordinator: navigationStream)
    case .c:
      CView(coordinator: navigationStream)
    case .d:
      DView(coordinator: navigationStream)
    case .e:
      EView(coordinator: navigationStream)
    case .f:
      FView(coordinator: navigationStream)
    case .g:
      GView(coordinator: navigationStream)
    }
  }
}
