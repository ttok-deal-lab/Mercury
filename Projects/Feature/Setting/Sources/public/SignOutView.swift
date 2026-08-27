//
//  SignOutView.swift
//  MyPage
//
//  Created by 최수훈 on 11/8/25.
//

import SwiftUI

import AppFoundation
import UIComponent
import Domain
import Router

public struct SignOutView: View {
  
  // MARK: - private property
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  @Inject private var tokenInvalidator: AccessTokenInvalidatable
  @State private var modelData: SettingModelData
  @State private var isChecked: Bool = false
  @State private var signOutError: Error?
  
  public init(settingUsecase: SettingUsecasable) {
    self.modelData = SettingModelData(
      settingUsecase: settingUsecase
    )
  }
  
  public var body: some View {
    VStack(spacing: .zero) {
      MercuryNavigationBar() {
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
          Text(L10n.signoutCheckComment)
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutral.color)
        } icon: {
          ZStack {
            Asset.Images.sucessLine.image
              .opacity(isChecked ? 0 : 1) // 체크되면 투명해짐
            
            Asset.Images.successBlue.image
              .opacity(isChecked ? 1 : 0) // 체크되면 선명해짐
          }
        }
        .padding(.top, 21)
        .onTapGesture {
          
          withAnimation(.easeInOut(duration: 0.2)) {
            isChecked.toggle()
          }
        }
        
        Spacer()
        
        MercuryButton("탈퇴하기") {
          guard isChecked else { return }
          Task {
            do {
              try await modelData.signOut()
              // 토큰·유저정보·로컬 캐시를 모두 비우면 MainView 가 토큰 스트림을 받아
              // 루트를 SignInView 로 되돌린다.
              tokenInvalidator.invalidateAccessToken()
            } catch {
              signOutError = error
            }
          }
        }
        .disabled(!isChecked)
      }
      .padding(.horizontal, 20)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(.white)
    }
    .background(Asset.Colors.neutralWeak.color)
    .navigationBarBackButtonHidden()
    .alert(error: $signOutError)
  }
}

