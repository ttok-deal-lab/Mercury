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
  private var version: String = "1.20.1"
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
          Button {
            navigationStream.send(.pop)
          } label: {
            Asset.Images.arrowLeft.image
          }
        }
        
        ForEach(items, id: \.self) { item in
          
          if item == SettingItemType.terms.rawValue {
            MercuryMenuItemView(
              item: item,
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
        
        VStack(alignment: .leading, spacing: 0) {
          HStack() {
            Text("앱 버전 \(version)")
              .fonts(.bodySmallMedium)
              .foregroundStyle(Asset.Colors.neutralSubtler.color)
            Text("업데이트하기")
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
            .padding(.top, 20)
          
          Text("오픈소스 라이선스 보기")
            .fonts(.bodySmallMedium)
            .foregroundStyle(Asset.Colors.neutralSubtler.color)
            .mercuryUnderLine()
            .padding(.top, 16)
            .onTapGesture {
              // TODO: 오픈소스 라이선스 시트뷰 띄우기
              //            navigationStream.send(.presentFullScreen(1))
            }
        }
        
        Spacer()
      }
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
    case .logout:
      // TODO: 모달 띄우기
      print("logout Tapped")
      //      accessTokenManager.removeAccessToken()
    case .signOut:
      print("SignOut Tapped")
      
    }
  }
}

