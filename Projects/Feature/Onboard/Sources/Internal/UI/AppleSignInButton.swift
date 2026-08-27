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
  var completion: () async throws -> Void
  
  var body: some View {
    Button {
      Task {
        try await completion()
      }
    } label: {
      ZStack {
        Text("Apple로 로그인")
          .fonts(.bodyMediumMedium)
          .foregroundStyle(Asset.Colors.neutralWhite.color)
        HStack(spacing: .zero) {
          Asset.Images.apple.image
            .resizable()
            .renderingMode(.template)
            .foregroundStyle(.white)
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundStyle(.white)
          Spacer()
        }
      }
      .frame(height: 52)
      .padding(.horizontal, 20)
      .background(.black)
      .clipShape(Capsule())
    }
  }
}
