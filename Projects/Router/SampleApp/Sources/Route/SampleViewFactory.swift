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
  
  func makeView(_ route: SampleRoute, eventSubject: PassthroughSubject<NavigationEvent<SampleRoute>, Never>) -> some View {
    switch route {
    case .a:
      AView(coordinator: eventSubject)
    case .b:
      BView(coordinator: eventSubject)
    case .c:
      CView(coordinator: eventSubject)
    case .d:
      DView(coordinator: eventSubject)
    case .e:
      EView(coordinator: eventSubject)
    case .f:
      FView(coordinator: eventSubject)
    case .g:
      GView(coordinator: eventSubject)
    }
  }
}
