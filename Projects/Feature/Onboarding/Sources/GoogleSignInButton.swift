//
//  GoogleSignInButton.swift
//  Onboarding
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import AppFoundation
import SwiftUI
import GoogleSignIn

public struct GoogleSignInButton: View {
  @StateObject private var signInManager = GoogleSignInManager()

  public init() {
    
  }
  
  public var body: some View {
    ZStack {
      Button("Sign In with Google") {
        signInManager.signIn()
      }
    }
  }
}

class GoogleSignInManager: ObservableObject {

  init() { }
  
  func signIn() {
    guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {
      return
    }
    
    GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
      guard let result = result else {
        print("Error: \(error?.localizedDescription ?? "Unknown error")")
        return
      }
      print(result.user.accessToken.tokenString)
    }
  }
  
  func signOut() {
    GIDSignIn.sharedInstance.signOut()
  }
}

