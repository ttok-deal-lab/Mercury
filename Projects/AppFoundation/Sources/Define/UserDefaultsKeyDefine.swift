//
//  StringDefine.swift
//  AppFoundation
//
//  Created by 송하민 on 9/28/24.
//

import Foundation

public enum LocalStorageKey: String {
  /// 앱 최초 구동 여부
  case isAppFirst
  /// 로그인 토큰 정보
  case signInTokenInfo
  /// 로그인 유저 정보
  case signInUserInfo
}
