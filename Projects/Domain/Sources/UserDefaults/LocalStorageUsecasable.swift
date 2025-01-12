//
//  UserDefaultsUsecasable.swift
//  Domain
//
//  Created by 송하민 on 1/12/25.
//

import AppFoundation

public protocol LocalStorageUsecasable {
  func setModel<T: Codable>(_ value: T, forKey key: LocalStorageKey)
  func getModel<T: Codable>(forKey key: LocalStorageKey, as type: T.Type) -> T?
  func set<T>(_ value: T, forKey key: LocalStorageKey) where T: Any
  func get<T>(forKey key: LocalStorageKey) -> T?
  func remove(forKey key: LocalStorageKey)
}
