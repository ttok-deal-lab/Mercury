//
//  Untitled.swift
//  Domain
//
//  Created by 송하민 on 1/12/25.
//

import Foundation

import AppFoundation

public final class LocalStorageUsecase: LocalStorageUsecasable {
  private let localStorageRepositorable: LocalStorageRepositorable
  
  public init(localStorageRepositorable: LocalStorageRepositorable) {
    self.localStorageRepositorable = localStorageRepositorable
  }
  
  public func setModel<T>(_ value: T, forKey key: LocalStorageKey) async where T : Decodable, T : Encodable {
    await localStorageRepositorable.setModel(value, forKey: key)
  }
  
  public func getModel<T>(forKey key: LocalStorageKey, as type: T.Type) async -> T? where T : Decodable, T : Encodable {
    await localStorageRepositorable.getModel(forKey: key, as: type)
  }
  
  public func set<T>(_ value: T, forKey key: LocalStorageKey) async {
    await localStorageRepositorable.set(value, forKey: key)
  }
  
  public func get<T>(forKey key: LocalStorageKey) async -> T? {
    await localStorageRepositorable.get(forKey: key)
  }
  
  public func remove(forKey key: LocalStorageKey) async {
    await localStorageRepositorable.remove(forKey: key)
  }
  
}
