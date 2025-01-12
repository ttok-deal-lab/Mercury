//
//  UserDefaultsManager.swift
//  AppFoundation
//
//  Created by 송하민 on 1/12/25.
//

import Foundation

public class UserDefaultsManager: UserDefaultsManagable {
  public static let shared = UserDefaultsManager()
  private let userDefaults = UserDefaults.standard
  private init() { }
  
  public func set<T>(_ value: T, forKey key: UserDefaultsKey) where T: Any {
    userDefaults.set(value, forKey: key.rawValue)
  }
  
  public func get<T>(forKey key: UserDefaultsKey) -> T? {
    return userDefaults.value(forKey: key.rawValue) as? T
  }
  
  public func remove(forKey key: UserDefaultsKey) {
    userDefaults.removeObject(forKey: key.rawValue)
  }
}
