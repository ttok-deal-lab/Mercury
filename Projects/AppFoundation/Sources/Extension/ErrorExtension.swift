//
//  ErrorExtension.swift
//  AppFoundation
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

public extension Error {
  func toMercuryError() -> MercuryError {
    if let mercuryErr = self as? MercuryError {
      return mercuryErr
    } else {
      return MercuryError(code: (self as NSError).code)
    }
  }
}
