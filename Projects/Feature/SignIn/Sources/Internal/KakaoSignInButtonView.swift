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
  var completion: () throws -> Void
  var body: some View {
    Button {
      Task {
        try completion()
      }
    } label: {
      ZStack {
        Text("카카오로 로그인")
          .foregroundStyle(.black)
        HStack {
          Asset.Images.kakao.image
            .scaledToFit()
            .frame(width: 24, height: 24)
            .padding(.leading, 5)
          Spacer()
        }
      }
      .padding()
      .frame(width: 335,height: 52)
      .background(.yellow)
      .clipShape(Capsule())
    }
  }
}

