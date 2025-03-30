//
//  UserDefaultsClient.swift
//  Domain
//
//  Created by 송하민 on 1/12/25.
//

import AppFoundation

public protocol LocalStorageRepositorable {
  func setModel<T: Codable>(_ value: T, forKey key: LocalStorageKey) async
  func getModel<T: Codable>(forKey key: LocalStorageKey, as type: T.Type) async -> T?
  func set<T>(_ value: T, forKey key: LocalStorageKey) async where T: Any
  func get<T>(forKey key: LocalStorageKey) async -> T?
  func remove(forKey key: LocalStorageKey) async
}
