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
  @ObservedObject var signInModelData: SignInModelData
  @Binding var error: MercuryError?
  
  var body: some View {
    Button {
      Task {
        do {
          try await signInModelData.oauthSignIn(.apple)
        } catch let error as MercuryError {
          self.error = error
        }
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
