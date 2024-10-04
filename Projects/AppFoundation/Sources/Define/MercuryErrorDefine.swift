//
//  MercuryErrorDefine.swift
//  AppFoundation
//
//  Created by 송하민 on 8/4/24.
//

import Foundation

public enum MercuryErrorDefine: Int {
  
  // MARK: - Common
  
  /// 알 수 없는 에러
  case unknown
  /// 온라인이 아님
  case failToConnectInternet
  /// 정상 server status code가 아님
  case failToStatusCodes
  /// Data를 JSON으로 파싱하지 못함
  case failToDeserializedDataToJSON
  
  
  // MARK: - Map
  
  /// 알 수 없는 위치권한 상태
  case unknownLocationAuthenticationStatus
  /// 사용자 위치정보 없음
  case failToGetUserLocationCoordinate
  
  
  // MARK: - SignIn
  
  /// 로그인 시도했으나 리턴값 nil
  case nilFromSignIn
  /// 로그인 취소
  case cancelUserLogin
}

