//
//  ToastTestView.swift
//  UIComponent
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI

import UIComponent

struct ToastTestView: View {
  @State var isShowToast: Bool = false
  
  var body: some View {
    VStack {
      Button {
        Toast.shared.present(title: "asdf")
      } label: {
        Text("show toast")
      }
    }
  }
}


#Preview {
  ToastTestView()
}
