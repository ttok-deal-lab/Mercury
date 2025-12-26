//
//  StringDefine.swift
//  AppFoundation
//
//  Created by 송하민 on 9/28/24.
//

import Foundation

public enum LocalStorageKey: String { // 추가만 하고 수정은 절대 불가. (하위호환 이슈 고려)
  /// 앱 최초 구동 여부
  case isAppFirst
  /// 메인 탭 최초 진입 여부
  case isTabEnterFirst
  /// 로그인 토큰 정보
  case signInTokenInfo
  /// 로그인 유저 정보
  case signInUserInfo
  /// 최근 본 매물
  case recentViwedSales
}
