//
//  AView.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI

import Coordinator

struct BView: View {
  @EnvironmentObject var coordinator: GlobalCoordinator<SampleRoute>
  
  var body: some View {
    ZStack {
      Color(.red).opacity(0.3)
      
      VStack {
        Text("B")
          .font(.title)
        RouterView()
      }
    }
  }
}
