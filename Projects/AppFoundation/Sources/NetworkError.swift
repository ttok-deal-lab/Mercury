//
//  NetworkError.swift
//  AppFoundation
//
//  Created by 송하민 on 12/28/25.
//


public enum NetworkError: Int, Error {
  case unknownError = 400
  case failToConvertURL
  case unauthorized
  case invalidStatusCode
  
  public var description: String {
    switch self {
    case .unknownError: "알 수 없는 오류"
    case .failToConvertURL: "URL 치환 실패"
    case .unauthorized: "엑세스토큰 인증 실패"
    case .invalidStatusCode: "유효하지 않은 범위"
    }
  }
}

/// HTTP 응답 실패의 상태 코드를 보존한다. 화면이 404/5xx 등 계약상 의미 있는 실패를 구분할 수 있다.
public struct HTTPStatusError: Error, Sendable {
  public let statusCode: Int

  public init(statusCode: Int) {
    self.statusCode = statusCode
  }
}
