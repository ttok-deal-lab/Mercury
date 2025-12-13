//
//  CourtSaleItem.swift
//  Infrastructure
//
//  Created by 송하민 on 8/30/25.
//

import Foundation

/// 경매물건 DTO
struct CourtSaleItemDTO: Decodable {
  var id: Int
  var salesAddress: String
  var salesCategories: [String]
  var salesDateTime: String
  
}
