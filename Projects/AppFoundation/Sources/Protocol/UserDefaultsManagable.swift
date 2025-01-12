//
//  UserDefaultsManagable.swift
//  AppFoundation
//
//  Created by 송하민 on 1/12/25.
//

import Foundation

public protocol UserDefaultsManagable {
  func setModel<T: Codable>(_ value: T, forKey key: UserDefaultsKey)
  func getModel<T: Codable>(forKey key: UserDefaultsKey, as type: T.Type) -> T?
  func set<T>(_ value: T, forKey key: UserDefaultsKey) where T: Any
  func get<T>(forKey key: UserDefaultsKey) -> T?
  func remove(forKey key: UserDefaultsKey)
}
