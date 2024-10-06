//
//  AppPages.swift
//  MercuryApp
//
//  Created by 송하민 on 10/5/24.
//

import Foundation
import SwiftUI

public enum AppPage: Hashable, Identifiable {
  
  public var id: String {
    switch self {
    case .tutorial(let tutorial):
      return tutorial.id
    case .auction(let auction):
      return auction.id
    case .map:
      return "map"
    }
  }
  
  public enum Tutorial: Hashable, Identifiable {
    public var id: String {
      switch self {
      case .tutorialIntro:
        return "tutorialIntro"
      case .tutorialSelectionCategory:
        return "tutorialSelectionCategory"
      case .tutorialSelectionRegion:
        return "tutorialSelectionRegion"
      }
    }
    case tutorialIntro
    case tutorialSelectionCategory
    case tutorialSelectionRegion
  }
  
  public enum Auction: Hashable, Identifiable {
    public var id: String {
      switch self {
      case .recommendAuction:
        return "recommendAuction"
      }
    }
    case recommendAuction
  }
  
  case tutorial(Tutorial)
  case auction(Auction)
  case map
}
