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
    
    if let queryParam {
      var queryItems: [URLQueryItem] = []
      queryItems = queryParam.compactMap { key, value in
        convertToQueryItem(key: key, value: value)
      }
      urlComponents.queryItems = queryItems.isEmpty ? nil : queryItems
    }
    
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
  
  func request() async throws {
    
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
