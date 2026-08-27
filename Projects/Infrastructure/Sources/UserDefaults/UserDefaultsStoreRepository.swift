//
//  UserDefaultsManager.swift
//  AppFoundation
//
//  Created by 송하민 on 1/12/25.
//

import Foundation

import AppFoundation
import Domain

public final actor UserDefaultsStoreRepository: LocalStorageRepositorable {
  private let userDefaults = UserDefaults.standard
  
  public init() { }
  
  public func isKeyExist(forKey key: String) async -> Bool {
    return userDefaults.object(forKey: key) != nil
  }
  
  public func setModel<T: Codable>(_ value: T, forKey key: String) async {
    do {
      let encodedData = try JSONEncoder().encode(value)
      userDefaults.set(encodedData, forKey: key)
    } catch {
      Log.debug("Failed to encode \(value) for key \(key): \(error)")
    }
  }

  public func getModel<T: Codable>(forKey key: String, as type: T.Type) async -> T? {
    guard let data = userDefaults.data(forKey: key) else { return nil }
    do {
      return try JSONDecoder().decode(T.self, from: data)
    } catch {
      Log.debug("Failed to decode data for key \(key): \(error)")
      return nil
    }
  }
  
  public func set<T>(_ value: T, forKey key: String) async where T: Any {
    userDefaults.set(value, forKey: key)
  }
  
  public func get<T>(forKey key: String) async -> T? {
    return userDefaults.value(forKey: key) as? T
  }
  
  public func remove(forKey key: String) async {
    userDefaults.removeObject(forKey: key)
  }
}
