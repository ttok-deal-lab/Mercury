//
//  Filter.swift
//  AppFoundation
//
//  Created by 송하민 on 10/6/24.
//

import Foundation
import SwiftData

@Model
public class Filter: Identifiable, ObservableObject {
  public var id: UUID
  public var favoriteCategories: [String]
  public var favoriteRegions: [String]
  
  private static var shared: Filter?
  
  public init(favoriteCategories: [AuctionCategory] = [], favoriteRegions: [Region] = []) {
    self.id = UUID()
    self.favoriteCategories = favoriteCategories.map { $0.rawValue }
    self.favoriteRegions = favoriteRegions.map { $0.rawValue }
  }
}
