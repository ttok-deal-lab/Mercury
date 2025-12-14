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
      MercuryNavigationBar(L10n.settingNoti) {
        Button {
          navigationStream.send(.pop)
        } label: {
          Asset.Images.arrowLeft.image
        }
      }
      
      MercuryMenuItemView(
        item: L10n.settingNoti,
        description: L10n.settingNotiDescription,
        left: .description,
        rightView: {
          if #available(iOS 26.0, *) {
            Toggle("", isOn: $isNotificationOn)
              .onChange(of: isNotificationOn) {
                toggleNotofication(isNotificationOn)
              }
              .labelsHidden()
              .glassEffect()
          } else {
            Toggle("", isOn: $isNotificationOn)
              .onChange(of: isNotificationOn) {
                toggleNotofication(isNotificationOn)
              }
              .labelsHidden()
          }
        })
      Spacer()
    }
    .navigationBarBackButtonHidden()
  }
  
  private func toggleNotofication(_ isToggleOn: Bool) {
    if isToggleOn {
      MercuryToast.shared.present(title: L10n.settingNotiAgree, toastType: .common)
    } else {
      MercuryToast.shared.present(title: L10n.settingNotiDecline, toastType: .urgent)
    }
  }
}

