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
  var completion: () throws -> Void
  
  var body: some View {
    Button {
      Task {
        try completion()
      }
    } label: {
      Text("Sign In with Google")
    }
  }
}
