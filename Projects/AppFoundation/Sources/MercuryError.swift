//
//  MercuryError.swift
//  AppFoundation
//
//  Created by 송하민 on 8/4/24.
//

import Foundation

public class MercuryError: Error {
  private let code: Int
  
  public var define: MercuryErrorDefine?
  public var description: String {
    return "문제가 발생했습니다.\n[error code: \(self.code)]"
  }
  
  public init(code: Int) {
    self.code = code
  }

  public init(_ errorDefine: MercuryErrorDefine) {
    self.define = errorDefine
    self.code = errorDefine.rawValue
  }
}

extension MercuryError: Equatable {
  public static func == (lhs: MercuryError, rhs: MercuryError) -> Bool {
    return lhs.code == rhs.code
  }
}



