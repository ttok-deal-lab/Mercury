//
//  BottomSheetTestView.swift
//  UIComponent
//
//  Created by 송하민 on 5/4/25.
//

import SwiftUI

struct BottomSheetTestView: View {
  
  @State private var show = false
  
  var body: some View {
    Button("Show") { show.toggle() }
      .bottomSheet2(isPresented: $show) {
        VStack(spacing: 12) {
          ForEach(0..<40) { Text("Row \($0)") }
        }
        .padding()
      }
  }
}
