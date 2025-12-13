//
//  NetworkError.swift
//  Network
//
//  Created by 송하민 on 11/2/24.
//

import Foundation

public enum NetworkError: Int, Error {
  case failToConvertURL = 400
  case unauthorized
  case invalidStatusCode
  
  public var description: String {
    switch self {
    case .failToConvertURL: "URL 치환 실패"
    case .unauthorized: "엑세스토큰 인증 실패"
    case .invalidStatusCode: "유효하지 않은 범위"
    }
  }
}
