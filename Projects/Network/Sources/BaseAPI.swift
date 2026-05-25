//
//  BaseAPI.swift
//  Network
//
//  Created by 송하민 on 11/2/24.
//

import AppFoundation
import Foundation
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

  func request<T: Decodable>(_ model: T.Type) async throws -> T
  where T: Decodable
  func request() async throws
}

extension BaseAPI {
  public var domain: String? { nil }

  public var headers: [String: String]? {
    [
      "Content-Type": "application/json"
    ]
  }

  public var additionalHeaders: [String: String]? { nil }
  public var requestBody: [String: Any]? { nil }
  public var queryParam: [String: Any]? { nil }

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

  public func request<T: Decodable>(_ model: T.Type) async throws -> T {
    do {
      let request = try makeURLRequest()
      let (data, response) = try await session.data(for: request)

      guard let http = response as? HTTPURLResponse else {
        throw NetworkError.invalidStatusCode
      }

      logResponseHeaders(http, url: request.url)

      if http.statusCode == 401 {
        MercuryContainer.shared
          .resolve(AccessTokenInvalidatable.self)
          .invalidateAccessToken()
        throw NetworkError.unauthorized
      }

      handleAuthorizationRefresh(http)

      guard (200...299).contains(http.statusCode) else {
        throw NetworkError.invalidStatusCode
      }

      return try JSONDecoder().decode(T.self, from: data)
    } catch {
      throw mapError(error)
    }
  }

  public func request() async throws {
    do {
      let request = try makeURLRequest()
      let (_, response) = try await session.data(for: request)

      guard let http = response as? HTTPURLResponse else {
        throw NetworkError.invalidStatusCode
      }

      logResponseHeaders(http, url: request.url)

      if http.statusCode == 401 {
        MercuryContainer.shared
          .resolve(AccessTokenInvalidatable.self)
          .invalidateAccessToken()
        throw NetworkError.unauthorized
      }

      handleAuthorizationRefresh(http)

      guard (200...299).contains(http.statusCode) else {
        throw NetworkError.invalidStatusCode
      }
    } catch {
      throw mapError(error)
    }
  }
}

extension BaseAPI {
  fileprivate func handleAuthorizationRefresh(_ response: HTTPURLResponse) {
    let raw = response.value(forHTTPHeaderField: "Authorization") ?? ""
    let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmed.isEmpty else {
      print("[TOKEN REFRESH] no Authorization header in response")
      return
    }
    MercuryContainer.shared
      .resolve(AuthorizationRefreshable.self)
      .refreshAccessToken(rawValue: trimmed)
  }
}

extension BaseAPI {
  fileprivate func logResponseHeaders(_ response: HTTPURLResponse, url: URL?) {
    let urlString = url?.absoluteString ?? "unknown"
    let status = response.statusCode
    let headers = response.allHeaderFields

    let sortedKeys = headers.keys
      .compactMap { $0 as? String }
      .sorted { $0.lowercased() < $1.lowercased() }

    let header = "========== [RESP HEADERS] =========="
    let meta = "URL   : \(urlString)"
    let st = "STATUS: \(status)"
    let count = "COUNT : \(sortedKeys.count)"
    let footer = "===================================="

    print(header)
    print(meta)
    print(st)
    print(count)

    let chunkSize = 800
    for key in sortedKeys {
      let value = headers[key].map { "\($0)" } ?? ""
      let line = "• \(key): \(value)"

      if line.count <= chunkSize {
        print(line)
        continue
      }

      var start = line.startIndex
      var index = 0
      while start < line.endIndex {
        let end =
          line.index(start, offsetBy: chunkSize, limitedBy: line.endIndex)
          ?? line.endIndex
        print("[\(index)] \(line[start..<end])")
        start = end
        index += 1
      }
    }

    print(footer)
  }
}

extension BaseAPI {
  fileprivate func makeURLRequest() throws -> URLRequest {
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
      comps.queryItems = queryParam.flatMap { key, value in
        convertToQueryItems(key: key, value: value)
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

extension BaseAPI {
  /// 배열 값은 같은 key 를 반복하는 URLQueryItem 으로 직렬화한다.
  /// OpenAPI 3.0 의 기본 array 직렬화(`style: form`, `explode: true`)와 일치하며,
  /// 단일 값(`String` / `Bool` / 숫자)도 1개짜리 배열로 일관 처리한다.
  fileprivate func convertToQueryItems(key: String, value: Any?) -> [URLQueryItem]
  {
    guard let unwrapped = value else { return [] }

    switch unwrapped {
    case let v as String:
      return [URLQueryItem(name: key, value: v)]
    case let v as Bool:
      return [URLQueryItem(name: key, value: v ? "true" : "false")]
    case let v as CustomStringConvertible where isPrimitiveNumeric(v):
      return [URLQueryItem(name: key, value: v.description)]
    case let arr as [String]:
      return arr.map { URLQueryItem(name: key, value: $0) }
    case let arr as [Bool]:
      return arr.map { URLQueryItem(name: key, value: $0 ? "true" : "false") }
    case let arr as [any CustomStringConvertible]:
      return arr.compactMap { element in
        guard isPrimitiveNumeric(element) else { return nil }
        return URLQueryItem(name: key, value: element.description)
      }
    default:
      return []
    }
  }

  fileprivate func isPrimitiveNumeric(_ value: CustomStringConvertible) -> Bool
  {
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
    return URLSession(
      configuration: config,
      delegate: delegate,
      delegateQueue: nil
    )
  }()
}
