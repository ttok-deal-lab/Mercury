//
//  AView.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI

import Router

struct EView: View {
  @EnvironmentObject var coordinator: GlobalCoordinator<SampleRoute>
  
  var body: some View {
    ZStack {
      Color(.cyan).opacity(0.3)
      
      VStack {
        Text("E")
          .font(.title)
        RouterView()
      }
    }
  }
}
