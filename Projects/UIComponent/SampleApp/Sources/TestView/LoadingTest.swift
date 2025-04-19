//
//  LoadingTest.swift
//  UIComponent
//
//  Created by 송하민 on 4/19/25.
//

import SwiftUI

import UIComponent

import Lottie

struct LoadingTest: View {
  @State var isLoading: Bool = false
  
  var body: some View {
    ZStack {
      Button {
        self.isLoading.toggle()
      } label: {
        Text("Toggle loading")
      }
    }
    .loading($isLoading)
  }
}
