//
//  PushPrintView.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI

import Coordinator

struct FullScreenPrintView: View {
  @EnvironmentObject var coordinator: GlobalCoordinator<SampleRoute>
  
  var body: some View {
    VStack {
      Text("in full screen stack")
      ScrollView(.horizontal) {
        HStack {
          Text("full count -> \(coordinator.routePath.fullScreenNavigationPath.count)")
        }
      }
      .padding(.horizontal, 20)
    }
  }
}
