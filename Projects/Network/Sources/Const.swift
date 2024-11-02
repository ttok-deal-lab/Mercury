//
//  Const.swift
//  Network
//
//  Created by 송하민 on 11/2/24.
//

import Foundation

public enum Const {
  /// 캐싱된 데이터 먼저, 없으면 request
  public static let cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
  /// 최대 타임아웃. 초 단위
  public static let timeout: CGFloat = 5
}
