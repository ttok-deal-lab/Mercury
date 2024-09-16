//
//  MockAPI.swift
//  Data
//
//  Created by 송하민 on 8/4/24.
//

import Foundation
import Moya

public enum MockAPI {
  case mockingAPI
}

extension MockAPI: TargetType {

  public var baseURL: URL {
    return RESTDefine.baseURL(.testDomain)!
  }
  
  public var path: String {
    switch self {
    case .mockingAPI:
      return "joke/Any"
    }
  }
  
  public var method: Moya.Method {
    switch self {
    case .mockingAPI:
      return .get
    }
  }
  
  public var task: Moya.Task {
    switch self {
    case .mockingAPI:
      return .requestPlain
    }
  }
  
  public var headers: [String : String]? {
    return [:]
  }
  
  
}
