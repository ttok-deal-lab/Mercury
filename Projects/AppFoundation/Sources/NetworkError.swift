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
