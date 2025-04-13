//
//  SignInButtonView.swift
//  Onboard
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Domain

struct SignInButtonView: View {
  let type: OauthProvider
  let completion: () async -> Void

  var body: some View {
    Group {
      switch type {
      case .apple:
        AppleSignInButton(completion: completion)
      case .google:
        GoogleSignInButtonView(completion: completion)
      case .naver:
        NaverSignInButtonView(completion: completion)
      case .kakao:
        KakaoSignInButtonView(completion: completion)
      }
    }
  }
}
