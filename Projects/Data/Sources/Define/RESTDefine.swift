//
//  RESTDefine.swift
//  Data
//
//  Created by 송하민 on 8/4/24.
//

import Foundation

enum Domain {
  case testDomain
}

struct RESTDefine {
  
#if DEBUG
  static let testBase = "https://v2.jokeapi.dev/"
#else
  static let testBase = "https://v2.jokeapi.dev/"
#endif
 
  static func baseURL(_ domain: Domain) -> URL? {
    switch domain {
    case .testDomain:
      return URL(string: RESTDefine.testBase)
    }
  }

}
