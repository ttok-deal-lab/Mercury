//
//  NetworkSessionManager.swift
//  DataSampleApp
//
//  Created by 송하민 on 8/4/24.
//

import Foundation
import Alamofire

protocol NetworkSessionManageable {
  var configuration { get }
}

class NetworkSessionManager: Alamofire.Session {
  
}

fileprivate class AlamofireSession: Alamofire.Session, NetworkSessionManageable {
  fileprivate static let configuration: Alamofire.Session = {
    let configuration = URLSessionConfiguration.default
    configuration.headers = HTTPHeaders.default
    configuration.timeoutIntervalForRequest = 60
    configuration.timeoutIntervalForResource = 60
    configuration.requestCachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
    
    return Alamofire.Session(configuration: configuration)
  }()
}
