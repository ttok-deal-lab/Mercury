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
 
  @ObservedObject var signInModelData: SignInModelData
  @Binding var error: MercuryError?
 
  public var body: some View {
    Button {
      Task {
        do {
          try await signInModelData.oauthSignIn(.naver)
        } catch let error as MercuryError {
          self.error = error
        }
      }
    } label: {
      ZStack {
        Text("네이버로 로그인")
          .foregroundStyle(.black)
        HStack {
          Image(asset: UIComponentAsset.Images.naverLogo)
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .padding(.leading, 5)
          Spacer()
        }
      }
      .padding()
      .frame(width: 335,height: 50)
      .background(.green)
      .clipShape(Capsule())
    }
  }
}
