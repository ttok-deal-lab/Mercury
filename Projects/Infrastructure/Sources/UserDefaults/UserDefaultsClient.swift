//
//  UserDefaultsManager.swift
//  AppFoundation
//
//  Created by 송하민 on 1/12/25.
//

import Foundation

import AppFoundation
import Domain

public final class UserDefaultsClient: LocalStorageClient {
  public static let shared = UserDefaultsClient()
  private let userDefaults = UserDefaults.standard
  private init() { }
  
  public func setModel<T: Codable>(_ value: T, forKey key: LocalStorageKey) {
    do {
      let encodedData = try JSONEncoder().encode(value)
      userDefaults.set(encodedData, forKey: key.rawValue)
    } catch {
      print("Failed to encode \(value) for key \(key.rawValue): \(error)")
    }
  }

  public func getModel<T: Codable>(forKey key: LocalStorageKey, as type: T.Type) -> T? {
    guard let data = userDefaults.data(forKey: key.rawValue) else { return nil }
    do {
      return try JSONDecoder().decode(T.self, from: data)
    } catch {
      print("Failed to decode data for key \(key.rawValue): \(error)")
      return nil
    }
  }
  
  public func set<T>(_ value: T, forKey key: LocalStorageKey) where T: Any {
    userDefaults.set(value, forKey: key.rawValue)
  }
  
  public func get<T>(forKey key: LocalStorageKey) -> T? {
    return userDefaults.value(forKey: key.rawValue) as? T
  }
  
  public func remove(forKey key: LocalStorageKey) {
    userDefaults.removeObject(forKey: key.rawValue)
  }
}
