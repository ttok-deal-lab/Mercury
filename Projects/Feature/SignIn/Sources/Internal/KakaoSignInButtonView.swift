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
  @ObservedObject var signInModelData: SignInModelData
  @Binding var error: MercuryError?
  
  public var body: some View {
    Button {
      Task {
        do {
          try await signInModelData.oauthSignIn(.kakao)
        } catch let error as MercuryError {
          self.error = error
        }
      }
    } label: {
      ZStack {
        Text("카카오로 로그인")
          .foregroundStyle(.black)
        HStack {
          Image(asset: UIComponentAsset.Images.kakaoLogo)
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
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

