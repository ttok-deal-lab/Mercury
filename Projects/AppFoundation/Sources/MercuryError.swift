//
//  MercuryError.swift
//  AppFoundation
//
//  Created by 송하민 on 8/4/24.
//

import Foundation

public class MercuryError: Error {
  
  public enum ErrorFrom {
    case server
    case ownModule(ModuleFrom)
    
    public enum ModuleFrom {
      case data
      case map
      case uiComponent
      case doamin
      case analysis
      case auction
      case mainTabbar
      case appleSignin
      case googleSignin
    }
  }
  
  // MARK: - private properties
  
  private let errorFrom: ErrorFrom
  private let code: Int
  
  
  // MARK: - public properties
  
  public var description: String {
    return "[error code: \(self.code)\nfrom: \(errorFrom)]"
  }
  
  
  // MARK: - life cycle
  
  public init(code: Int) {
    self.errorFrom = .server
    self.code = code
  }
  
  public init(from: ErrorFrom, _ errorDefine: MercuryErrorDefine) {
    self.errorFrom = from
    self.code = errorDefine.rawValue
  }
  
  
  // MARK: - private method
  
  // MARK: - public method
  
}



