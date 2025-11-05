//
//  ProfileView.swift
//  MyPage
//
//  Created by 최수훈 on 10/28/25.
//

import SwiftUI

import Domain
import UIComponent

struct UserProfileView: View {
  
  @Binding var modelData: MyPageModelData
  
    var body: some View {
      VStack {
        HStack {
          Text(modelData.userProfile.name)
            .fonts(.titleLargeBold)
          Spacer()
        }
        HStack {
          modelData.userProfile.provider.toImage()
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 18, height: 18)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 6))
          Text("\(modelData.userProfile.provider.toText())로 로그인")
          Spacer()
        }
      }
      .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
}

extension OauthProvider {
  func toText() -> String {
    switch self {
    case .google:
      return "구글"
    case .apple:
      return "애플"
    case .kakao:
      return "카카오"
    case .naver:
      return "네이버"
    }
  }
  
  func toImage() -> Image {
    switch self {
    case .google:
      Asset.Images.googleLogo.image
    case .apple:
      Asset.Images.appleLogo.image
    case .kakao:
      Asset.Images.kakaoLogo.image
    case .naver:
      Asset.Images.naverLogo.image
    }
  }
}
