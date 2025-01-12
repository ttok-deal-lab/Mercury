//
//  GoogleSignInButton.swift
//  Onboarding
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import SwiftUI

import AppFoundation
import UIComponent

struct GoogleSignInButtonView: View {
  @ObservedObject var signInModelData: SignInModelData
  @Binding var error: MercuryError?
  
  var body: some View {
    Button {
      Task {
        do {
          try await signInModelData.oauthSignIn(signInType: .google)
        } catch let error as MercuryError {
          self.error = error
        }
      }
    } label: {
      Text("Sign In with Google")
    }
  }
}
