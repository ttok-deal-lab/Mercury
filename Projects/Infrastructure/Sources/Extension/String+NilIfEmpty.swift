//
//  String+NilIfEmpty.swift
//  Infrastructure
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

extension String {
  /// 외부 API 가 빈 문자열로 "없음" 을 표현할 때 nil 로 바꾼다.
  var nilIfEmpty: String? {
    isEmpty ? nil : self
  }
}
