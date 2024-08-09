//
//  MercuryErrorDefine.swift
//  AppFoundation
//
//  Created by 송하민 on 8/4/24.
//

import Foundation

public enum MercuryErrorDefine: Int {
  /// 알 수 없는 에러
  case unknown
  /// 온라인이 아님
  case failToConnectInternet
  /// 정상 server status code가 아님
  case failToStatusCodes
  /// Data를 JSON으로 파싱하지 못함
  case failToDeserializedDataToJSON
}

