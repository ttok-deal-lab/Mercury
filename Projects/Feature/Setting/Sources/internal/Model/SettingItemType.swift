//
//  SettingItemType.swift
//  MyPage
//
//  Created by 최수훈 on 11/6/25.
//

import Foundation
import UIComponent

enum SettingItemType: CaseIterable {
//  case notification // MARK: - 1차 MVP 이후
  case terms
  case settingLogout
  case signOut
  
  var title: String {
    switch self {
//    case .notification: L10n.settingNotificationManage
    case .terms: L10n.settingTerms
    case .settingLogout: L10n.settingLogout
    case .signOut: L10n.settingSignout
    }
  }
}
