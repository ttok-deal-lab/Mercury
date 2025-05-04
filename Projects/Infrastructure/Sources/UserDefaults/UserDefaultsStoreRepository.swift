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
  
  public func isKeyExist(forKey key: LocalStorageKey) async -> Bool {
    return userDefaults.object(forKey: key.rawValue) != nil
  }
  
  public func setModel<T: Codable>(_ value: T, forKey key: LocalStorageKey) async {
    do {
      let encodedData = try JSONEncoder().encode(value)
      userDefaults.set(encodedData, forKey: key.rawValue)
    } catch {
      print("Failed to encode \(value) for key \(key.rawValue): \(error)")
    }
  }

  public func getModel<T: Codable>(forKey key: LocalStorageKey, as type: T.Type) async -> T? {
    guard let data = userDefaults.data(forKey: key.rawValue) else { return nil }
    do {
      return try JSONDecoder().decode(T.self, from: data)
    } catch {
      print("Failed to decode data for key \(key.rawValue): \(error)")
      return nil
    }
  }
  
  public func set<T>(_ value: T, forKey key: LocalStorageKey) async where T: Any {
    userDefaults.set(value, forKey: key.rawValue)
  }
  
  public func get<T>(forKey key: LocalStorageKey) async -> T? {
    return userDefaults.value(forKey: key.rawValue) as? T
  }
  
  public func remove(forKey key: LocalStorageKey) async {
    userDefaults.removeObject(forKey: key.rawValue)
  }
}
