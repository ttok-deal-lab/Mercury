//
//  KakaoLocalAPI.swift
//  Infrastructure
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation

import AppFoundation

/// 카카오 로컬 REST API (dapi.kakao.com).
/// 서버 API 가 아니라서 BaseAPI 를 쓰지 않는다. BaseAPI 는 401 을 받으면 우리 서비스 토큰을 무효화(로그아웃) 하는데,
/// 카카오 키 문제로 401 이 와도 사용자가 로그아웃되면 안 되기 때문.
enum KakaoLocalAPI {
  case searchAddress(query: String)
  case coordToAddress(latitude: Double, longitude: Double)
  
  private static let baseURL = "https://dapi.kakao.com/v2/local/"
  
  private var path: String {
    switch self {
    case .searchAddress: return "search/address.json"
    case .coordToAddress: return "geo/coord2address.json"
    }
  }
  
  private var queryItems: [URLQueryItem] {
    switch self {
    case let .searchAddress(query):
      return [URLQueryItem(name: "query", value: query), URLQueryItem(name: "size", value: "30")]
    case let .coordToAddress(latitude, longitude):
      return [URLQueryItem(name: "x", value: String(longitude)), URLQueryItem(name: "y", value: String(latitude))]
    }
  }
  
  func request<T: Decodable>(_ type: T.Type) async throws -> T {
    guard let key = CommonDefine.kakaoRestAPIKey, !key.isEmpty, !key.hasPrefix("$") else {
      // Sensitive.xcconfig 에 KAKAO_REST_API_KEY 가 없을 때
      Log.debug("카카오 로컬 API 키 없음: XCConfigs/Sensitive.xcconfig 의 KAKAO_REST_API_KEY 를 채우세요")
      throw MercuryError(.unknown)
    }
    guard var components = URLComponents(string: Self.baseURL + path) else {
      throw MercuryError(.unknown)
    }
    components.queryItems = queryItems
    guard let url = components.url else { throw MercuryError(.unknown) }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue("KakaoAK \(key)", forHTTPHeaderField: "Authorization")
    
    let (data, response) = try await URLSession.shared.data(for: request)
    guard let http = response as? HTTPURLResponse else { throw NetworkError.invalidStatusCode }
    guard (200...299).contains(http.statusCode) else {
      Log.debug("카카오 로컬 API 실패 status=\(http.statusCode) body=\(String(data: data, encoding: .utf8) ?? "")")
      throw HTTPStatusError(statusCode: http.statusCode)
    }
    return try JSONDecoder().decode(T.self, from: data)
  }
}
