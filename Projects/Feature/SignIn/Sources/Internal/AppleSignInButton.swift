//
//  appleSignInButton.swift
//  SignIn
//
//  Created by 송하민 on 1/11/25.
//

import SwiftUI

import AppFoundation
import UIComponent

struct AppleSignInButton: View {
  var completion: () throws -> Void
  
  var body: some View {
    Button {
      Task {
        try completion()
      }
    } label: {
      HStack {
        Image(systemName: "applelogo")
        Text("Continue with Apple")
      }
      .padding()
      .background(.black)
      .foregroundStyle(.white)
      .clipShape(RoundedRectangle(cornerRadius: 8))
    }
  }
}
