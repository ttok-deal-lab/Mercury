//
//  PushPrintView.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI

import Router

struct PushPrintView: View {
  @EnvironmentObject var coordinator: GlobalCoordinator<SampleRoute>
  
  var body: some View {
    VStack {
      Text("in push stack")
      ScrollView(.horizontal) {
        HStack {
          Text("push count -> \(coordinator.routePath.navigationPath.count)")
        }
      }
      .padding(.horizontal, 20)
    }
  }
}
