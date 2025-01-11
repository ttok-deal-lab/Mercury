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
  
  var body: some View {
    Button {
      signInModelData.signIn(signInType: .google)
    } label: {
      Text("Sign In with Google")
    }
  }
}
