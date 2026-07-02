//
//  UserDefaultsClient.swift
//  Domain
//
//  Created by 송하민 on 1/12/25.
//

import AppFoundation

public protocol LocalStorageRepositorable {
  func isKeyExist(forKey key: String) async -> Bool
  func setModel<T: Codable>(_ value: T, forKey key: String) async
  func getModel<T: Codable>(forKey key: String, as type: T.Type) async -> T?
  func set<T>(_ value: T, forKey key: String) async where T: Any
  func get<T>(forKey key: String) async -> T?
  func remove(forKey key: String) async
}
