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

import NaverThirdPartyLogin

struct NaverSignInButtonView: View {
  var completion: () throws -> Void
  public var body: some View {
    Button {
      Task {
        try completion()
      }
    } label: {
      ZStack {
        Text("네이버로 로그인")
          .foregroundStyle(.black)
        HStack {
          Asset.Images.naver.image
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .foregroundStyle(.white)
            .padding(.leading, 5)
          Spacer()
        }
      }
      .padding()
      .frame(width: 335,height: 52)
      .background(.green)
      .clipShape(Capsule())
    }
  }
}
