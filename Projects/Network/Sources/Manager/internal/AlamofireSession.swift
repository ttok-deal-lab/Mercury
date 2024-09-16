//
//  NetworkSessionManager.swift
//  DataSampleApp
//
//  Created by 송하민 on 8/4/24.
//

import Foundation
import Alamofire

class AlamofireSession: Alamofire.Session {
  static let configuration: Alamofire.Session = {
    let configuration = URLSessionConfiguration.default
    configuration.headers = HTTPHeaders.default
    configuration.timeoutIntervalForRequest = 60
    configuration.timeoutIntervalForResource = 60
    configuration.requestCachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
    
    return Alamofire.Session(configuration: configuration)
  }()
}
