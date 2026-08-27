//
//  Untitled.swift
//  Domain
//
//  Created by 송하민 on 1/12/25.
//

import Foundation

import AppFoundation

public final class LocalStorageUsecase: LocalStorageUsecasable {
  private let repository: LocalStorageRepositorable
  
  public init(repository: LocalStorageRepositorable) {
    self.repository = repository
  }
  
  public func isKeyExist(forKey key: String) async -> Bool {
    await repository.isKeyExist(forKey: key)
  }
  
  public func setModel<T>(_ value: T, forKey key: String) async where T : Decodable, T : Encodable {
    await repository.setModel(value, forKey: key)
  }
  
  public func getModel<T>(forKey key: String, as type: T.Type) async -> T? where T : Decodable, T : Encodable {
    await repository.getModel(forKey: key, as: type)
  }
  
  public func set<T>(_ value: T, forKey key: String) async {
    await repository.set(value, forKey: key)
  }
  
  public func get<T>(forKey key: String) async -> T? {
    await repository.get(forKey: key)
  }
  
  public func remove(forKey key: String) async {
    await repository.remove(forKey: key)
  }
  
}
