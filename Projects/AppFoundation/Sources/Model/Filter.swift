//
//  Filter.swift
//  AppFoundation
//
//  Created by 송하민 on 10/6/24.
//

import Foundation
import SwiftData

@Model
public class Filter: Identifiable {
  public var id: UUID
  public var favoriteCategories: [String]
  public var favoriteRegions: [String]
  
  private static var shared: Filter?
  
  public init(favoriteCategories: [AuctionCategory] = [], favoriteRegions: [Region] = []) {
    self.id = UUID()
    self.favoriteCategories = favoriteCategories.map { $0.rawValue }
    self.favoriteRegions = favoriteRegions.map { $0.rawValue }
  }
  
  public static func getShared(context: ModelContext) -> Filter {
    if let existing = shared {
      return existing
    }
    
//    do {
//      let descriptor = FetchDescriptor<Filter>()
//      let filters = try context.fetch(descriptor)
//      if let first = filters.first {
//        shared = first
//        return first
//      }
//    } catch {
//      print("Error fetching Filter: \(error)")
//    }
    
    let newFilter = Filter()
    context.insert(newFilter)
    shared = newFilter
    return newFilter
  }
}
