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
  var completion: () async throws -> Void
  
  var body: some View {
    Button {
      Task {
        try await completion()
      }
    } label: {
      ZStack {
        Text("구글로 로그인")
          .fonts(.bodyMediumMedium)
          .foregroundStyle(Asset.Colors.gray900TextBlack.color)
        HStack(spacing: .zero) {
          Asset.Images.google.image
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
          Spacer()
        }
      }
      .frame(height: 52)
      .padding(.horizontal, 20)
      .background(.white)
      .clipShape(Capsule())
      .overlay {
        Capsule()
          .strokeBorder(lineWidth: 1)
          .foregroundStyle(Asset.Colors.gray200BorderDark.color)
      }
    }
  }
}
