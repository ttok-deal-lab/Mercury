//
//  KakaoSignInButtonView.swift
//  SignIn
//
//  Created by 최수훈 on 3/30/25.
//

import Foundation
import SwiftUI

import AppFoundation
import UIComponent

import KakaoSDKAuth

struct KakaoSignInButtonView: View {
  var completion: () async throws -> Void
  var body: some View {
    Button {
      Task {
        try await completion()
      }
    } label: {
      ZStack {
        Text("카카오로 로그인")
          .fonts(.bodyMediumMedium)
          .foregroundStyle(Asset.Colors.textBlack.color)
        HStack {
          Asset.Images.kakao.image
            .scaledToFit()
            .frame(width: 24, height: 24)
            .padding(.leading, 5)
          Spacer()
        }
      }
      .frame(height: 52)
      .padding(.horizontal, 20)
      .background(.yellow)
      .clipShape(Capsule())
    }
  }
}

