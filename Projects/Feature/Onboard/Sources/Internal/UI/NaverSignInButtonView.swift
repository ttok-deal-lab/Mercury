//
//  NaverSignInButtonView.swift
//  SignIn
//
//  Created by 최수훈 on 1/17/25.
//

import Foundation
import SwiftUI

import AppFoundation
import UIComponent

struct NaverSignInButtonView: View {
  var completion: () async  throws -> Void
  var body: some View {
    Button {
      Task {
        try await completion()
      }
    } label: {
      ZStack {
        Text("네이버로 로그인")
          .fonts(.bodyMediumMedium)
          .foregroundStyle(Asset.Colors.gray10TextWhite.color)
        HStack {
          Asset.Images.naver.image
            .renderingMode(.template)
            .scaledToFit()
            .frame(width: 24, height: 24)
            .foregroundStyle(.white)
            .padding(.leading, 5)
          Spacer()
        }
      }
      .frame(height: 52)
      .padding(.horizontal, 20)
      .background(.green)
      .clipShape(Capsule())
    }
  }
}
