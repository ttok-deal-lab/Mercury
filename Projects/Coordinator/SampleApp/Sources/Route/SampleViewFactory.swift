//
//  SampleViewFactory.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI

import Coordinator

struct SampleViewFactory: ViewFactory {
  
  @ViewBuilder
  func makeView(_ route: SampleRoute) -> some View {
    switch route {
    case .a:
      AView()
    case .b:
      BView()
    case .c:
      CView()
    case .d:
      DView()
    case .e:
      EView()
    case .f:
      FView()
    case .g:
      GView()
    }
  }
}
