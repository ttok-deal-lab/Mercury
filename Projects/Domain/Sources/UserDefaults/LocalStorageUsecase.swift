//
//  Untitled.swift
//  Domain
//
//  Created by 송하민 on 1/12/25.
//

import Foundation

import AppFoundation

public final class LocalStorageUsecase: LocalStorageUsecasable {
  private let localStorageClient: LocalStorageClient
  
  public init(localStorageClient: LocalStorageClient) {
    self.localStorageClient = localStorageClient
  }
  
  public func setModel<T>(_ value: T, forKey key: LocalStorageKey) where T : Decodable, T : Encodable {
    localStorageClient.setModel(value, forKey: key)
  }
  
  public func getModel<T>(forKey key: LocalStorageKey, as type: T.Type) -> T? where T : Decodable, T : Encodable {
    localStorageClient.getModel(forKey: key, as: type)
  }
  
  public func set<T>(_ value: T, forKey key: LocalStorageKey) {
    localStorageClient.set(value, forKey: key)
  }
  
  public func get<T>(forKey key: LocalStorageKey) -> T? {
    localStorageClient.get(forKey: key)
  }
  
  public func remove(forKey key: LocalStorageKey) {
    localStorageClient.remove(forKey: key)
  }
  
  
}
