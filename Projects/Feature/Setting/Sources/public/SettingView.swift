//
//  SettingView.swift
//  MyPage
//
//  Created by 최수훈 on 11/5/25.
//

import SwiftUI
import Combine

import AppFoundation
import Domain
import UIComponent
import Router

import FirebaseRemoteConfig

public struct SettingView: View {
  
  // MARK: - internal property
  
  // MARK: - private property
  @EnvironmentObject private var coordinator: NavigationCoordinator<FeatureRoute>
  @State private var modelData: SettingModelData
  private let items: [SettingItemType] = SettingItemType.allCases
  private var isNeedUpdate: Bool = true
  @Inject private var accessTokenManager: AccessTokenManagable
  
  // MARK: - life cycle
  public init() {
    self.modelData = SettingModelData(remoteConfig: RemoteConfig.remoteConfig())
  }
  func remoteTest() async throws {
    try await self.modelData.test()
  }
  public var body: some View {
    ZStack {
      VStack(alignment: .leading, spacing: 0) {
        MercuryNavigationBar(L10n.tabSetting) {
          Button {
            coordinator.pop()
          } label: {
            Asset.Images.arrowLeft.image
          }
        }
        
        ForEach(items, id: \.self) { item in
          
          if item == .terms {
            MercuryMenuItemView(
              item: item.title,
              left: .textLabel,
              rightView: {
                Asset.Images.arrowRightNoShaftGray.image
              }) {
                onTapItem(item)
              }
              .padding(.bottom, 10)
          } else {
            MercuryMenuItemView(
              item: item.title,
              left: .textLabel,
              rightView: {
                Asset.Images.arrowRightNoShaftGray.image
              }) {
                onTapItem(item)
              }
          }
          
        }
        
        VStack(alignment: .leading, spacing: 0) {
          HStack() {
            Text("\(L10n.commonAppVersion) \(Bundle.main.appVersion)")
              .fonts(.bodySmallMedium)
              .foregroundStyle(Asset.Colors.neutralSubtler.color)
            
            Text(L10n.settingUpdate)
              .fonts(.bodySmallMedium)
              .foregroundStyle(Asset.Colors.neutralSubtler.color)
              .mercuryUnderLine()
              .task {
                // TODO: 앱스토어 가기
                //              if let url = URL(string: "itms-apps://itunes.apple.com/app/[@id]"),
                //                                  UIApplication.shared.canOpenURL(url)
                //              {
                //                  if #available(iOS 10.0, *) {
                //                      UIApplication.shared.open(url, options: [:], completionHandler: nil)
                //                  } else {
                //                      UIApplication.shared.openURL(url)
                //                  }
                //              }
              }
          }
          
          Text("\(L10n.settingOpenLicense)")
            .fonts(.bodySmallMedium)
            .foregroundStyle(Asset.Colors.neutralSubtler.color)
            .mercuryUnderLine()
            .padding(.top, 16)
            .onTapGesture {
              // TODO: 오픈소스 라이선스 시트뷰 띄우기
              //            navigationStream.send(.presentFullScreen(1))
            }
        }
        .padding(.top, 20)
        .padding(.leading, 20)
        
        Spacer()
      }
    }
    .background(Asset.Colors.neutralWeak.color)
    .navigationBarBackButtonHidden()
    .onLoad {
      Task {
        try await remoteTest()
      }
    }
  }
  
  private func onTapItem(_ item: SettingItemType) {
    switch item {
      // MARK: - 1차 MVP 이후
      //    case .notification:
      //      navigationStream.send(.push(.setting(.init(route: .notification))))
    case .terms:
      coordinator.push(.setting(SettingRoute(route: .terms(TermsRoute(route: .termsList)))))
    case .settingLogout:
      // TODO: 모달 띄우기
      MercuryAlert.shared
        .present(
          type:
              .cancallable(
                information: .init(
                  title: "\(L10n.settingAlertLogout)",
                  description: "",
                  confirmButtonTitle: L10n.commonYes,
                  cancelButtonTitle: L10n.commonNo,
                  onConfirm: {
                    accessTokenManager.removeAccessToken()
                    coordinator.popToRoot()
                  },
                  onCancel: { }
                )
              )
        )
      
    case .signOut:
      print("SignOut Tapped")
    }
  }
}

