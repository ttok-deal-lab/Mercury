//
//  BaseAPI.swift
//  Network
//
//  Created by 송하민 on 11/2/24.
//

import Foundation

import AppFoundation

import Pulse

public protocol BaseAPI {
  var baseURL: String { get }
  var domain: String? { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var headers: [String: String]? { get }
  var additionalHeaders: [String: String]? { get }
  var requestBody: [String: Any]? { get }
  var queryParam: [String: Any]? { get }
  
  func request<T: Decodable>(_ model: T.Type) async throws -> T where T: Decodable
  func request() async throws
}

public extension BaseAPI {
  var domain: String? {
    return nil
  }
  
  var headers: [String: String]? {
    return [
      "Content-Type": "application/json"
    ]
  }
  
  var additionalHeaders: [String: String]? {
    return nil
  }
  
  var requestBody: [String: Any]? {
    return nil
  }
  
  var queryParam: [String : Any]? {
    return nil
  }
  
  private var session: URLSession {
    let config = URLSessionConfiguration.default
    let delegate = URLSessionProxyDelegate()
    return URLSession(configuration: config, delegate: delegate, delegateQueue: nil)
  }
  
  func request<T: Decodable>(_ model: T.Type) async throws -> T {
    do {
      let request = try makeURLRequest()
      let (data, response) = try await session.data(for: request)
      
      guard let http = response as? HTTPURLResponse,
            (200...299).contains(http.statusCode)
      else {
        print("Network Status Code Err: \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
        throw NetworkError.invalidStatusCode
      }
      /// 401이면 갱신 해야 함.
      return try JSONDecoder().decode(T.self, from: data)
    } catch {
      let nsError = error as NSError
      if nsError.code == NSURLErrorCancelled {
        throw error
      }
      throw NetworkError.unknownError
    }
  }
  
  func request() async throws {
    let request = try makeURLRequest()
    let (_, response) = try await session.data(for: request)
    
    guard let http = response as? HTTPURLResponse,
          (200...299).contains(http.statusCode)
    else {
      throw NetworkError.invalidStatusCode
    }
  }
}

private extension BaseAPI {
  func makeURLRequest() throws -> URLRequest {
    let plainURLString: String = {
      if let domain = domain {
        return baseURL.appending(domain).appending(path)
      }
      return baseURL.appending(path)
    }()
    
    guard var comps = URLComponents(string: plainURLString) else {
      throw NetworkError.failToConvertURL
    }
    if let queryParam {
      comps.queryItems = queryParam.compactMap { key, value in
        convertToQueryItem(key: key, value: value)
      }
    }
    guard let url = comps.url else { throw NetworkError.failToConvertURL }
    
    print("Request URL: \(url)")
    
    var request = URLRequest(
      url: url,
      cachePolicy: Const.cachePolicy,
      timeoutInterval: Const.timeout
    )
    request.httpMethod = method.rawValue
    
    print("Request method: \(String(describing: request.httpMethod))")
    
    if let requestBody {
      request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
      print("Request body: \(requestBody)")
    }
    if let headers { request.allHTTPHeaderFields = headers }
    if let additionalHeaders {
      request.allHTTPHeaderFields?.merge(additionalHeaders) { _, new in new }
      print("Request Header: \(additionalHeaders)")
    }
    return request
  }
}

/// queryItem converting
private extension BaseAPI {
  func convertToQueryItem(key: String, value: Any?) -> URLQueryItem? {
    guard let unwrapped = value else { return nil }
    
    switch unwrapped {
    case let v as String:
      return URLQueryItem(name: key, value: v)
    case let v as Bool:
      return URLQueryItem(name: key, value: v ? "true" : "false")
    case let v as CustomStringConvertible where isPrimitiveNumeric(v):
      return URLQueryItem(name: key, value: v.description)
    default:
      return nil
    }
  }
  
  private func isPrimitiveNumeric(_ value: CustomStringConvertible) -> Bool {
    switch value {
    case is Int, is Int8, is Int16, is Int32, is Int64,
      is UInt, is UInt8, is UInt16, is UInt32, is UInt64,
      is Float, is Double:
      return true
    default:
      return false
    }
  }
  
}
