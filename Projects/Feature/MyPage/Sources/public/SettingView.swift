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
      VStack(alignment: .leading, spacing: 0) {
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
        .padding(.top, 20)
        .padding(.leading, 20)
        
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
    case .terms:
      print("serviceAgreement Tapped")
      navigationStream.send(.push(.terms(.init(route: .terms))))
    case .logout:
      // TODO: 모달 띄우기
      MercuryAlert.shared
        .present(
          type:
              .cancallable(
                information: .init(
                  title: "로그아웃 하시겠어요?",
                  description: "",
                  confirmButtonTitle: "네",
                  cancelButtonTitle: "아니요",
                  onConfirm: {
                    accessTokenManager.removeAccessToken()
                    navigationStream.send(.popToRoot)
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

