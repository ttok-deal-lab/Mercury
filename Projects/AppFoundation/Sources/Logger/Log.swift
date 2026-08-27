//
//  Log.swift
//  AppFoundation
//
//  Created by DevLifter on 7/6/26.
//

import Foundation

/// 디버그(DEBUG) 빌드에서만 출력되는 경량 로거.
///
/// 릴리즈 빌드에서는 `#if DEBUG` 로 본문이 제거되어 아무 것도 하지 않으며,
/// `@autoclosure` 로 메시지 문자열 자체도 평가되지 않는다.
public enum Log {
  /// 파일·라인 추적 정보와 함께 출력한다. (일반 디버그 로그)
  public static func debug(
    _ message: @autoclosure () -> String,
    file: String = #fileID,
    line: Int = #line
  ) {
    #if DEBUG
    print("🐛 [\(file):\(line)] \(message())")
    #endif
  }

  /// 이미 정렬된 멀티라인 블록 등, 접두사 없이 원문 그대로 출력한다.
  public static func raw(_ message: @autoclosure () -> String) {
    #if DEBUG
    print(message())
    #endif
  }
}
