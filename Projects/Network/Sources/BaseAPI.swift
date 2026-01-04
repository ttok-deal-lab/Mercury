//
//  BaseAPI.swift
//  Network
//
//  Created by 송하민 on 11/2/24.
//

import Foundation

import AppFoundation

import Pulse

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
  var domain: String? { nil }

  var headers: [String: String]? {
    [
      "Content-Type": "application/json"
    ]
  }

  var additionalHeaders: [String: String]? { nil }
  var requestBody: [String: Any]? { nil }
  var queryParam: [String : Any]? { nil }

  private var session: URLSession { BaseAPISession.session }

  private func mapError(_ error: Error) -> Error {
    if let urlError = error as? URLError, urlError.code == .cancelled {
      return error
    }
    if error is DecodingError {
      return error
    }
    if error is NetworkError {
      return error
    }
    return NetworkError.unknownError
  }

  func request<T: Decodable>(_ model: T.Type) async throws -> T {
    do {
      let request = try makeURLRequest()
      let (data, response) = try await session.data(for: request)

      guard let http = response as? HTTPURLResponse else {
        throw NetworkError.invalidStatusCode
      }

      guard (200...299).contains(http.statusCode) else {
        throw NetworkError.invalidStatusCode
      }

      return try JSONDecoder().decode(T.self, from: data)
    } catch {
      throw mapError(error)
    }
  }

  func request() async throws {
    do {
      let request = try makeURLRequest()
      let (_, response) = try await session.data(for: request)

      guard let http = response as? HTTPURLResponse else {
        throw NetworkError.invalidStatusCode
      }

      guard (200...299).contains(http.statusCode) else {
        throw NetworkError.invalidStatusCode
      }
    } catch {
      throw mapError(error)
    }
  }
}

private extension BaseAPI {
  func makeURLRequest() throws -> URLRequest {
    func join(_ a: String, _ b: String) -> String {
      switch (a.hasSuffix("/"), b.hasPrefix("/")) {
      case (true, true):
        return a + b.dropFirst()
      case (false, false):
        return a + "/" + b
      default:
        return a + b
      }
    }

    let plainURLString: String = {
      if let domain = domain {
        return join(join(baseURL, domain), path)
      }
      return join(baseURL, path)
    }()

    guard var comps = URLComponents(string: plainURLString) else {
      throw NetworkError.failToConvertURL
    }

    if let queryParam {
      comps.queryItems = queryParam.compactMap { key, value in
        convertToQueryItem(key: key, value: value)
      }
    }

    guard let url = comps.url else {
      throw NetworkError.failToConvertURL
    }

    var request = URLRequest(
      url: url,
      cachePolicy: Const.cachePolicy,
      timeoutInterval: Const.timeout
    )

    request.httpMethod = method.rawValue

    if let requestBody {
      request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
    }

    if let headers {
      request.allHTTPHeaderFields = headers
    }

    if let additionalHeaders {
      request.allHTTPHeaderFields?.merge(additionalHeaders) { _, new in new }
    }

    return request
  }
}

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

  func isPrimitiveNumeric(_ value: CustomStringConvertible) -> Bool {
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

private enum BaseAPISession {
  static let delegate = URLSessionProxyDelegate()

  static let session: URLSession = {
    let config = URLSessionConfiguration.default
    return URLSession(configuration: config, delegate: delegate, delegateQueue: nil)
  }()
}
