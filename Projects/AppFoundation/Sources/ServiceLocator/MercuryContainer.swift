//
//  MercuryContainer.swift
//  AppFoundation
//
//  Created by 송하민 on 11/2/24.
//

import Foundation

public final class MercuryContainer {
  private var container: [ObjectIdentifier: Any] = [:]
  public static let shared = MercuryContainer()
  private init() { }
  
  public func register<T>(_ type: T.Type, instance: T) {
    let key = ObjectIdentifier(type)
    container[key] = instance
  }
  
  func resolve<T>() -> T {
    let key = ObjectIdentifier(T.self)
    if let value = container[key] as? T {
      return value
    }
    fatalError("\(T.self)의 인스턴스 등록되지 않음.")
  }
}
