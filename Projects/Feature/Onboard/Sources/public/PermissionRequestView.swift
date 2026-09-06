//
//  UserGrantVIew.swift
//  Onboard
//
//  Created by 송하민 on 4/30/25.
//

import Foundation
import SwiftUI
import Combine

import Router
import UIComponent

private enum Permission: CaseIterable {
  case alarm
  case location
  
  var text: String {
    switch self {
    case .alarm:
      "알림"
    case .location:
      "위치"
    }
  }
  
  var description: String {
    switch self {
    case .alarm:
      "알림 및 메시지 전송"
    case .location:
      "위치 및 부동산 찾기"
    }
  }
  
  var icon: Image {
    switch self {
    case .alarm:
      Asset.Images.noti.image
    case .location:
      Asset.Images.place.image
    }
  }
}

public struct PermissionRequestView: View {
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  @Bindable var modelData: OnboardingModelData
  
  public var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      VStack(spacing: .zero) {
        title()
          .padding(.top, 60)
        
        VStack(spacing: 30) {
          permissionTitle()
          permissionItems()
        }
        .padding(.top, 40)
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 40)
      
      VStack(alignment: .leading, spacing: .zero) {
        ZStack {
          Asset.Colors.gray50BackgroundMuted.color
          VStack(alignment: .leading, spacing: .zero) {
            introduce()
              .padding(.bottom, 24)
            introduceChange()
            
            Spacer()
            
            MercuryButton("확인") {
              // 오프라인이면 안내 시트를 띄우고 진행을 막는다.
              // 여기서 pop 해버리면 시트가 올라올 화면 자체가 사라진다.
              guard NetworkDisconnectPresenter.shared.ensureConnected() else { return }
              modelData.requestUserPermission()
              coordinator.pop()
            }
          }
          .padding(20)
        }
      }
      .ignoresSafeArea()
    }
  }

  
  private func title() -> some View {
    HStack {
      Text("앱 사용을 위해\n접근 권한을 허용해주세요.")
        .fonts(.headingSmallBold)
        .foregroundStyle(Asset.Colors.neutral.color)
      
      Spacer()
    }
  }

  private func permissionTitle() -> some View {
    HStack(spacing: .zero) {
      Text("선택 권한")
        .fonts(.bodyMediumMedium)
        .foregroundStyle(Asset.Colors.neutralSubtler.color)
      
      Spacer()
    }
  }

  private func permissionItems() -> some View {
    ForEach(Permission.allCases, id: \.self) { permission in
      HStack(spacing: .zero) {
        permission.icon
          .resizable()
          .frame(width: 26, height: 26)
        Text(permission.text)
          .fonts(.titleMediumMedium)
          .foregroundStyle(Asset.Colors.neutral.color)
          .padding(.leading, 12)
        Text(permission.description)
          .fonts(.bodySmallRegular)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
          .padding(.leading, 8)
        
        Spacer()
      }
    }
  }

  private func introduce() -> some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Text("접근 권한 안내")
          .fonts(.bodyMiniMedium)
          .foregroundStyle(Asset.Colors.neutral.color)
        Spacer()
      }
      
      HStack {
        Text("접근 권한은 서비스 사용 중 필요한 시점에 동의를 받고\n있습니다. 허용하지 않을 경우에도 해당 기능 외 서비스는 이용\n할 수 있습니다.")
          .fonts(.bodyMiniRegular)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
        Spacer()
      }
    }
  }

  private func introduceChange() -> some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Text("접근 권한 변경 안내")
          .fonts(.bodyMiniMedium)
          .foregroundStyle(Asset.Colors.neutral.color)
        Spacer()
      }
      
      HStack {
        Text("휴대폰 설정 > 앱 > 민들팽이")
          .fonts(.bodyMiniRegular)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
        Spacer()
      }
    }
  }


}
