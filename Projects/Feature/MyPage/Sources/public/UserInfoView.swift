//
//  ProfileView.swift
//  MyPage
//
//  Created by 최수훈 on 10/28/25.
//

import SwiftUI

import Domain

struct UserInfoView: View {
  
  @Binding var modelData: MyPageModelData
  
    var body: some View {
      VStack {
        HStack {
          Text(modelData.userProfile.name)
            .fonts(.titleLargeBold)
          Spacer()
        }
        HStack {
          Text("\(modelData.userProfile.provider.toText()) 로 로그인")
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
}
