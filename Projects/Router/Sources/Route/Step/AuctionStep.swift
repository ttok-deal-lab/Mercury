//
//  AuctionRoute.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//

import Foundation

public struct AuctionStep: Hashable {
  public private(set) var step: Step
  
  public init(step: Step) {
    self.step = step
  }
  
  public enum Step: Hashable {
    case recommendAuction(auctionId: Int)
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(step)
  }
}
