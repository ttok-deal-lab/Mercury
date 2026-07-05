//
//  DeepLinkParser.swift
//  Router
//
//  Created by DevLifter on 7/6/26.
//

import Foundation

/// `estateSlug://` URL 을 `DeepLink` 로 파싱한다.
///
/// 지원 형태
/// - `estateSlug://sales/{id}`
/// - `estateSlug://search?keyword=X`
/// - `estateSlug://home` · `estateSlug://favorite` · `estateSlug://mypage`
/// - 카카오 공유 실행 파라미터: `estateSlug://kakaolink?path=sales/{id}&keyword=X`
public enum DeepLinkParser {
  public static let scheme = "estateSlug"

  public static func parse(_ url: URL) -> DeepLink? {
    // 카카오톡 공유 실행 파라미터로 열린 경우: 카카오 앱 스킴 `kakao{앱키}://kakaolink?path=...`.
    // (스킴이 estateSlug 가 아니므로 host 로 먼저 분기한다)
    if url.host?.lowercased() == "kakaolink" {
      return parseKakaoExecution(url)
    }

    // 자체 스킴 딥링크: estateSlug://...
    guard url.scheme?.caseInsensitiveCompare(scheme) == .orderedSame else { return nil }

    return makeDeepLink(
      host: url.host?.lowercased(),
      pathComponents: url.pathComponents,
      queryItems: queryItems(of: url)
    )
  }

  // MARK: - Private

  private static func parseKakaoExecution(_ url: URL) -> DeepLink? {
    let items = queryItems(of: url)
    // path 예: "sales/123", "home", "search"
    let rawPath = items.first(where: { $0.name == "path" })?.value ?? ""
    let segments = rawPath.split(separator: "/").map(String.init)
    let host = segments.first?.lowercased()
    let pathComponents = ["/"] + segments.dropFirst() // host 를 제외한 나머지 경로
    return makeDeepLink(host: host, pathComponents: Array(pathComponents), queryItems: items)
  }

  private static func makeDeepLink(
    host: String?,
    pathComponents: [String],
    queryItems: [URLQueryItem]
  ) -> DeepLink? {
    switch host {
    case "sales":
      guard
        let idString = pathComponents.dropFirst().first,
        let id = Int(idString)
      else { return nil }
      return .auctionDetail(id: id)

    case "search":
      let keyword = queryItems.first(where: { $0.name == "keyword" })?.value ?? ""
      return .search(keyword: keyword)

    case "home":
      return .tab(.home)

    case "favorite":
      return .tab(.favorite)

    case "mypage":
      return .tab(.mypage)

    default:
      return nil
    }
  }

  private static func queryItems(of url: URL) -> [URLQueryItem] {
    URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems ?? []
  }
}
