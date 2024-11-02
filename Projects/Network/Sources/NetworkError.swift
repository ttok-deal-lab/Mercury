//
//  NetworkError.swift
//  Network
//
//  Created by 송하민 on 11/2/24.
//

import Foundation

public enum NetworkError: Error {
  case failToConvertURL
  
  public var description: String {
    switch self {
    case .failToConvertURL: "URL 치환 실패"
    }
  }
}
