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
      ZStack {
        Text("Apple로 로그인")
          .foregroundStyle(.white)
        HStack {
          Image(systemName: "applelogo")
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .foregroundStyle(.white)
            .padding(.leading, 5)
          Spacer()
        }
      }
      .padding()
      .frame(width: 335, height: 52)
      .background(.black)
      .clipShape(Capsule())
    }
  }
}
