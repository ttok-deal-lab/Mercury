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
  
  func makeView(_ route: SampleRoute, navigationSubject: PassthroughSubject<NavigationEvent<SampleRoute>, Never>) -> some View {
    switch route {
    case .a:
      AView(coordinator: navigationSubject)
    case .b:
      BView(coordinator: navigationSubject)
    case .c:
      CView(coordinator: navigationSubject)
    case .d:
      DView(coordinator: navigationSubject)
    case .e:
      EView(coordinator: navigationSubject)
    case .f:
      FView(coordinator: navigationSubject)
    case .g:
      GView(coordinator: navigationSubject)
    }
  }
}
