//
//  CommonDefine.swift
//  AppFoundation
//
//  Created by 송하민 on 8/9/24.
//

import Foundation

public class CommonDefine {
  
  public static let googleSignInClientId: String = "231639587392-4p1jbrhn6r16io5hspc05oulfvepi3mp.apps.googleusercontent.com"

  // MARK: - plist value

  public static let mapKey: String? = Bundle.main.object(forInfoDictionaryKey: "KAKAO_MAP_KEY") as? String
  public static let naverClientID = Bundle.main.object(forInfoDictionaryKey: "NAVER_SIGNIN_ID") as? String
  public static let naverClientSecret = Bundle.main.object(forInfoDictionaryKey: "NAVER_SIGNIN_SECRET") as? String
  public static let kakaoAuthKey = ""
  
}



