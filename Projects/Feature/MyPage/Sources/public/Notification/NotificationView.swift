//
//  NotificationView.swift
//  MyPage
//
//  Created by 최수훈 on 11/5/25.
//

import SwiftUI
import Combine

import UIComponent
import Router

public struct NotificationView: View {
  
  @State var isNotificationOn: Bool = false
  private var navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
  public init(navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    self.navigationStream = navigationStream
  }
  
  public var body: some View {
    VStack(spacing: 0) {
      MercuryNavigationBar("알림 설정 관리") {
        Button {
          navigationStream.send(.pop)
        } label: {
          Asset.Images.arrowLeft.image
        }
      }
      
      MercuryMenuItemView(
        item: "알림",
        description: "중요한 정보를 알림으로 전달드려요.",
        left: .description,
        rightView: {
          if #available(iOS 26.0, *) {
            Toggle("", isOn: $isNotificationOn)
              .labelsHidden()
              .glassEffect()
          } else {
            Toggle("", isOn: $isNotificationOn)
              .labelsHidden()
          }
        })
      Spacer()
    }
    .navigationBarBackButtonHidden()
  }
}

