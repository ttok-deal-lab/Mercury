//
//  BaseAPI.swift
//  Network
//
//  Created by 송하민 on 11/2/24.
//

import Foundation

import AppFoundation

public protocol BaseAPI {
  var baseURL: String { get }
  var domain: String? { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var headers: [String: String]? { get }
  var requestBody: [String: Any]? { get }
  var queryParam: [URLQueryItem]? { get }
  
  func request<T: Decodable>(_ model: T.Type) async throws -> T where T: Decodable
}

public extension BaseAPI {
  var domain: String? {
    return nil
  }
  
  var headers: [String: String]? {
    var header = ["Content-Type": "application/json"]
    if let tokenInfo = MercuryContainer.shared.resolve(SignInTokenInformable.self).tokenInfo.value {
      header["Authorization"] = tokenInfo.accessToken
    }
    return header
  }
  
  var requestBody: [String: Any]? {
    return nil
  }
  
  var queryParam: [URLQueryItem]? {
    return nil
  }
  
  func request<T: Decodable>(_ model: T.Type) async throws -> T {
    var plainURLString: String {
      if let domain = domain {
        return baseURL.appending(domain).appending(path)
      } else {
        return baseURL.appending(path)
      }
    }
    
    guard var urlComponents = URLComponents(string: plainURLString) else {
      throw NetworkError.failToConvertURL
    }
    urlComponents.queryItems = queryParam
    
    guard let finalURL = urlComponents.url else {
      throw NetworkError.failToConvertURL
    }
    
    var urlRequest = URLRequest(url: finalURL, cachePolicy: Const.cachePolicy, timeoutInterval: Const.timeout)
    
    urlRequest.httpMethod = method.rawValue
    
    if let requestBody {
      let bodyData = try? JSONSerialization.data(withJSONObject: requestBody, options: [])
      urlRequest.httpBody = bodyData
    }
    
    if let headers {
      urlRequest.allHTTPHeaderFields = headers
    }
    
    do {
      let (data, _) = try await URLSession.shared.data(for: urlRequest)
      let decodedModel = try JSONDecoder().decode(T.self, from: data)
      print("Network request: URL:: \(finalURL.absoluteString)\nresponse: \(decodedModel)")
      return decodedModel
    } catch {
      print("Decoding failed for URL:: \(finalURL.absoluteString)\nerror: \(error)")
      throw error
    }
  }
  
}
