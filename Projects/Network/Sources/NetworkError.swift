//
//  NetworkError.swift
//  Network
//
//  Created by 송하민 on 11/2/24.
//

import Foundation

public enum NetworkError: Error {
  case failToConvertURL
  case unauthorized
  
  public var description: String {
    switch self {
    case .failToConvertURL: "URL 치환 실패"
    case .unauthorized: "엑세스토큰 인증 실패"
    }
  }
}
