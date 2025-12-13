//
//  SalesPicture.swift
//  Domain
//
//  Created by 송하민 on 11/2/25.
//

import Foundation

public struct SalesPicture: Sendable, Equatable, Identifiable {
  public var id: Int { sequence }
  
  public let sequence: Int
  public let url: URL?
  
  public init(sequence: Int, url: URL?) {
    self.sequence = sequence
    self.url = url
  }
}
