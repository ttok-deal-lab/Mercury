//
//  MercuryError.swift
//  AppFoundation
//
//  Created by 송하민 on 8/4/24.
//

import Foundation

public class MercuryError: Error, Equatable {
  public static func == (lhs: MercuryError, rhs: MercuryError) -> Bool {
    return lhs.code == rhs.code
  }
  
  // MARK: - private properties
  
  private let code: Int
  
  
  // MARK: - public properties
  
  public var description: String {
    return "문제가 발생했습니다.\n[error code: \(self.code)]"
  }
  
  
  // MARK: - life cycle
  
  public init(code: Int) {
    self.code = code
  }

  public init(_ errorDefine: MercuryErrorDefine) {
    self.code = errorDefine.rawValue
  }
  
  
  // MARK: - private method
  
  // MARK: - public method
  
}



