//
//  RestAPIDefine.swift
//  Infrastructure
//
//  Created by 송하민 on 1/11/25.
//

enum DomainType {
  case common
  case auth
}

struct RestAPIDefine {
  #if DEBUG
  static let commonURL = "https://sherbet-api-gateway.dev.pursue503.com/api/sherbet-api/"
  static let authURL = "https://sherbet-api-gateway.dev.pursue503.com/api/sherbet-auth/"
  
  #elseif STAGE
  static let commonURL = "https://sherbet-api-gateway.dev.pursue503.com/api/sherbet-api/"
  static let authURL = "https://sherbet-api-gateway.dev.pursue503.com/api/sherbet-auth/"
  
  #else // release // TODO: production server 나오면 변경
  static let commonURL = "https://sherbet-api-gateway.dev.pursue503.com/api/sherbet-api/"
  static let authURL = "https://sherbet-api-gateway.dev.pursue503.com/api/sherbet-auth/"
  
  #endif
}

extension RestAPIDefine {
  static func base(_ type: DomainType) -> String {
    switch type {
    case .common:
      return RestAPIDefine.commonURL
    case .auth:
      return RestAPIDefine.authURL
    }
  }
}
