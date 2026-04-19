import XCTest
@testable import CustomSplash
import AppFoundation
import Domain

final class CustomSplashModelDataTests: XCTestCase {
  func testResolveLaunchLoginStateReturnsFalseAndClearsExpiredSession() async {
    let storage = InMemoryLocalStorageUsecase()
    await storage.setModel(
      UserAccessToken(value: "Bearer \(makeJWT(expiration: Date(timeIntervalSinceNow: -3600)))"),
      forKey: LocalStorageKey.signInTokenInfo.rawValue
    )
    await storage.setModel(
      UserInformation(id: 1, email: "expired@example.com", name: "Expired User", status: .active),
      forKey: LocalStorageKey.signInUserInfo.rawValue
    )

    let isLoggedIn = await CustomSplashModelData.resolveLaunchLoginState(localStorageUsecasable: storage)

    XCTAssertFalse(isLoggedIn)
    let storedToken: UserAccessToken? = await storage.getModel(forKey: LocalStorageKey.signInTokenInfo.rawValue, as: UserAccessToken.self)
    let storedUser: UserInformation? = await storage.getModel(forKey: LocalStorageKey.signInUserInfo.rawValue, as: UserInformation.self)
    XCTAssertNil(storedToken)
    XCTAssertNil(storedUser)
  }

  func testResolveLaunchLoginStateReturnsTrueForValidStoredSession() async {
    let storage = InMemoryLocalStorageUsecase()
    await storage.setModel(
      UserAccessToken(value: "Bearer \(makeJWT(expiration: Date(timeIntervalSinceNow: 3600)))"),
      forKey: LocalStorageKey.signInTokenInfo.rawValue
    )

    let isLoggedIn = await CustomSplashModelData.resolveLaunchLoginState(localStorageUsecasable: storage)

    XCTAssertTrue(isLoggedIn)
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

private final class InMemoryLocalStorageUsecase: LocalStorageUsecasable {
  private var codableStore: [String: Data] = [:]
  private var valueStore: [String: Any] = [:]

  func isKeyExist(forKey key: String) async -> Bool {
    codableStore[key] != nil || valueStore[key] != nil
  }

  func setModel<T: Codable>(_ value: T, forKey key: String) async {
    codableStore[key] = try? JSONEncoder().encode(value)
  }

  func getModel<T: Codable>(forKey key: String, as type: T.Type) async -> T? {
    guard let data = codableStore[key] else { return nil }
    return try? JSONDecoder().decode(type, from: data)
  }

  func set<T>(_ value: T, forKey key: String) async where T: Any {
    valueStore[key] = value
  }

  func get<T>(forKey key: String) async -> T? {
    valueStore[key] as? T
  }

  func remove(forKey key: String) async {
    codableStore.removeValue(forKey: key)
    valueStore.removeValue(forKey: key)
  }
}
