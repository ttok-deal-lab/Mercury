//
//  appleSignInButton.swift
//  SignIn
//
//  Created by 송하민 on 1/11/25.
//

import SwiftUI

import UIComponent

struct AppleSignInButton: View {
  
  @ObservedObject var signInModelData: SignInModelData
  
  var body: some View {
    Button {
      signInModelData.signIn(signInType: .apple)
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
