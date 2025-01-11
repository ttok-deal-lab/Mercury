//
//  RestAPIDefine.swift
//  Infrastructure
//
//  Created by 송하민 on 1/11/25.
//

enum DomainType {
  case commonBaseURL
}

struct RestAPIDefine {

  #if DEBUG
  static let baseURL = "http://sherbet-auth.dev.pursue503.com"
  
  #elseif STAGE
  static let baseURL = "http://sherbet-auth.dev.pursue503.com"
  
  #else // release
  static let baseURL = "http://sherbet-auth.dev.pursue503.com"
  
  #endif
  
  func domain(_ type: DomainType) -> String {
    switch type {
    case .commonBaseURL:
      return RestAPIDefine.baseURL
    }
  }
}
