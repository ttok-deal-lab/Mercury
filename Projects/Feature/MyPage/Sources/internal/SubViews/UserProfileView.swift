//
//  UserProfileView.swift
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
      VStack(spacing: 0){
        HStack {
          Text(modelData.userProfile?.name ?? "")
            .fonts(.titleLargeBold)
          Spacer()
        }
        .padding(.bottom, 6)
        
        HStack(spacing: 0) {
          modelData.userProfile?.provider.toImage()
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 18, height: 18)
            .padding(.trailing, 6)
          Text("\(modelData.userProfile?.provider.toText() ?? "")로 \(L10n.settingLogin)")
          Spacer()
        }
      }
      .padding(.horizontal, 20)
      .contentShape(Rectangle())
      .background(.white)
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
