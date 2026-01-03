//
//  SignOutView.swift
//  MyPage
//
//  Created by 최수훈 on 11/8/25.
//

import SwiftUI

import UIComponent
import Domain
import Router

public struct SignOutView: View {
  
  // MARK: - private property
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  @State private var modelData: SettingModelData
  @State private var isChecked: Bool = false
  
  public init(settingUsecase: SettingUsecasable) {
    self.modelData = SettingModelData(
      settingUsecase: settingUsecase
    )
  }
  public var body: some View {
    VStack(spacing: .zero) {
      MercuryNavigationBar(nil) {
        Button {
          coordinator.pop()
        } label: {
          Asset.Images.arrowLeft.image
        }
      }
      
      VStack(alignment: .leading, spacing: 8) {
        Text(L10n.signoutTitle)
          .fonts(.titleLargeBold)
          .foregroundStyle(Asset.Colors.neutral.color)
          .padding(.top, 19)
          .padding(.bottom, 24)
        
        BulletPointView(
          text: L10n.signoutDescription1.byChaWrapping,
          fonts: .bodySmallMedium,
          color: Asset.Colors.neutralSubtler.color
        )
        
        BulletPointView(
          text: L10n.signoutDescription2,
          fonts: .bodySmallMedium,
          color: Asset.Colors.neutralSubtler.color
        )
        .padding(.bottom, 24)
        
      }
      .padding(.horizontal, 20)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(.white)
      .padding(.bottom, 10)
      
      
      VStack(alignment: .leading) {
        Label {
          Text("탈퇴 전 안내 사항을 모두 확인했어요.")
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutral.color)
        } icon: {
          // TODO: boolean 값으로 체크 표시 아이콘 변경
          if !isChecked {
            Asset.Images.sucessLine.image
          } else {
            Asset.Images.successBlue.image
          }
          
        }
        .padding(.top, 21)
        .onTapGesture {
          isChecked.toggle()
        }
        
        Spacer()
        
        MercuryButton("탈퇴하기") {
          if isChecked {
            print("SignOut button Tapped")
          }
        }
      }
      .padding(.horizontal, 20)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(.white)
    }
    .background(Asset.Colors.neutralWeak.color)
    .navigationBarBackButtonHidden()
  }
}

