//
//  AView.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI
import Combine

import Router

struct BView: View {
  var coordinator: PassthroughSubject<NavigationEvent<SampleRoute>, Never>
  
  var body: some View {
    ZStack {
      Color(.red).opacity(0.3)
      
      VStack {
        Text("B")
          .font(.title)
        RouterView(coordinator: coordinator)
      }
    }
  }
}
