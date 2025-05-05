//
//  BottomSheetTestView.swift
//  UIComponent
//
//  Created by 송하민 on 5/4/25.
//

import SwiftUI

struct TraySheetTestView: View {
  
  @State private var show = false
  
  var body: some View {
    Button("Show tray sheet") { show.toggle() }
      .traySheet(isPresented: $show) {
        VStack(spacing: 12) {
          ForEach(0..<6) { Text("Row \($0)") }
        }
        .padding()
      }
  }
}
