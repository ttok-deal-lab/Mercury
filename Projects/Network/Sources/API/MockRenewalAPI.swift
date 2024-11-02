//
//  MockRenewalAPI.swift
//  Network
//
//  Created by 송하민 on 11/2/24.
//

import Foundation

public enum MockRenewalAPI: BaseAPI {
  case mockingAPI
  
  public var baseURL: String {
    "http://v2.jokeapi.dev/"
  }
  
  public var domain: String? {
    switch self {
    case .mockingAPI: "joke/"
    }
  }
  
  public var path: String {
    switch self {
    case .mockingAPI: "Any"
    }
  }
  
  public var method: HTTPMethod {
    switch self {
    case .mockingAPI: .get
    }
  }
}
