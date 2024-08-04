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
  
  private var description: String?
  private let errorFrom: ErrorFrom
  
  
  // MARK: - public properties
  
  
  // MARK: - life cycle
  
  public init(from: ErrorFrom, type: MercuryErrorDefine) {
    self.errorFrom = from
  }
  
  public init(_ error: any Error) {
    self.errorFrom = .server
  }
  
  // MARK: - private method
  
  // MARK: - public method
}



