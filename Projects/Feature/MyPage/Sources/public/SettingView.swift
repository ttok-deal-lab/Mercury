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

public struct SettingView: View {
  
  private let items: [String] = SettingItemType.allCases.map(\.rawValue)
  private var isNeedUpdate: Bool = true
  @Inject private var accessTokenManager: AccessTokenManagable
  
  private var navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
  public init(navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    self.navigationStream = navigationStream
  }
  
  public var body: some View {
    ZStack {
      VStack(spacing: 0) {
        MercuryNavigationBar("설정") {
          Asset.Images.arrowLeft.image
        }
        
        ForEach(items, id: \.self) { item in
          
          if item == SettingItemType.update.rawValue {
            MercuryMenuItemView(
              item: item,
              rightLabel: isNeedUpdate ? "업데이트하기" : nil ,
              left: .textLabel,
              rightView: {
                Asset.Images.arrowRightNoShaftGray.image
              }) {
                onTapItem(item)
              }
              .padding(.bottom, 10)
          } else {
            MercuryMenuItemView(
              item: item,
              left: .textLabel,
              rightView: {
                Asset.Images.arrowRightNoShaftGray.image
              }) {
                onTapItem(item)
              }
          }
          
        }
        Spacer()
      }
      // TODO: 앱 버전 가져오기
      // TODO: 오픈소스 라이선스 보기
    }
    .background(Asset.Colors.neutralWeak.color)
    .navigationBarBackButtonHidden()
  }
  
  private func onTapItem(_ item: String) {
    guard let item = SettingItemType(rawValue: item) else { return }
    switch item {
    case .notification:
      navigationStream.send(.push(.setting(.init(route: .notification))))
    case .agreement:
      print("serviceAgreement Tapped")
      navigationStream.send(.push(.agreement(.init(route: .agreements))))
    case .update:
      print("update Tapped")
      //      navigationStream.send(.push(.setting(.init(route: .notification))))
    case .logout:
      // TODO: 모달 띄우기
      print("logout Tapped")
      accessTokenManager.removeAccessToken()
    case .signOut:
      print("SignOut Tapped")
      
    }
  }
}

