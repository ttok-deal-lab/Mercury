import XCTest
@testable import Domain

final class UserAccessTokenTests: XCTestCase {
  func testIsExpiredReturnsTrueForExpiredJWT() {
    let token = UserAccessToken(value: "Bearer \(makeJWT(expiration: Date(timeIntervalSinceNow: -3600)))")

    XCTAssertTrue(token.isExpired)
    XCTAssertNotNil(token.expirationDate)
  }

  func testIsExpiredReturnsFalseForValidJWT() {
    let token = UserAccessToken(value: "Bearer \(makeJWT(expiration: Date(timeIntervalSinceNow: 3600)))")

    XCTAssertFalse(token.isExpired)
    XCTAssertNotNil(token.expirationDate)
  }

  func testMalformedTokenIsTreatedAsExpired() {
    let token = UserAccessToken(value: "not-a-jwt")

    XCTAssertTrue(token.isExpired)
    XCTAssertNil(token.expirationDate)
  }

  private func makeJWT(expiration: Date) -> String {
    let header = base64URL(["alg": "HS256", "typ": "JWT"])
    let payload = base64URL(["exp": Int(expiration.timeIntervalSince1970)])
    return "\(header).\(payload).signature"
  }

  private func base64URL(_ object: [String: Any]) -> String {
    let data = try! JSONSerialization.data(withJSONObject: object)
    return data.base64EncodedString()
      .replacingOccurrences(of: "+", with: "-")
      .replacingOccurrences(of: "/", with: "_")
      .replacingOccurrences(of: "=", with: "")
  }
}
