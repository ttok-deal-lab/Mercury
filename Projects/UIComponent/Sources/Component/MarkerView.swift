//
//  MarkerView.swift
//  UIComponent
//
//  Created by 송하민 on 8/10/24.
//

import Foundation
import SwiftUI

public struct MarkerView: View {
  public var body: some View {
    Rectangle()
      .backgroundStyle(.red)
      .clipShape(Capsule())
      .overlay {
        Text("marker")
      }
  }
}

//#Preview {
//  MarkerView()
//}
