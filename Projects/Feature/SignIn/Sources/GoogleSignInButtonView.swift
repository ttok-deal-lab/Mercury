//
//  GoogleSignInButton.swift
//  Onboarding
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

import AppFoundation
import UIComponent

public struct GoogleSignInButtonView: View {
  
  // MARK: - private property
  
  @StateObject private var store = SignInStore(signInClient: SignInClientLive())

  // MARK: - life cycle
  
  public init() {
    
  }
  
  public var body: some View {
    ZStack {
      Button {
        Task { @MainActor in 
          await store.signIn(for: .google)
        }
      } label: {
        Text("Sign In with Google")
      }
    }
  }

}
