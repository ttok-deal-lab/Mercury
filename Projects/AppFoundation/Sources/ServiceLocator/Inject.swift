//
//  Inject.swift
//  AppFoundation
//
//  Created by 송하민 on 11/2/24.
//

import Foundation

@propertyWrapper
public struct Inject<T> {
  public var wrappedValue: T
  
  public init() {
    self.wrappedValue = MercuryContainer.shared.resolve(T.self)
  }
}

@propertyWrapper
public struct LazyInject<T> {
  private class Storage {
    var value: T?
    init() { }
  }
  private let storage = Storage()
  private var initializer: () -> T
  
  public init() {
    self.initializer = {
      MercuryContainer.shared.resolve(T.self)
    }
  }
  
  public var wrappedValue: T {
    get {
      if storage.value == nil {
        storage.value = initializer()
      }
      return storage.value!
    }
  }
}
