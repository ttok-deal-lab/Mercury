//
//  AppleSignInButton.swift
//  Onboarding
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import SwiftUI
import AppFoundation

public struct AppleSignInButtonView: View {
  
  // MARK: - private property
  
  @StateObject private var store = SignInStore(signInClient: SignInClientLive())
  
  // MARK: - life cycle
  
  public init() {
    
  }
  
  public var body: some View {
    Button {
      Task {
        await store.signIn(for: .apple)
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
