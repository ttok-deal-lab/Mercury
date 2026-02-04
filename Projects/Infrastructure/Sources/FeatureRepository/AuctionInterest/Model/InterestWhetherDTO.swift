//
//  InterestWhetherDTO.swift
//  Infrastructure
//
//  Created by 최수훈 on 2/2/26.
//

import Foundation

import AppFoundation
import Domain

struct InterestWhetherDTO: Decodable, Sendable {
  let id: Int
  let isFavorite: Bool
  
  enum CodingKeys: String, CodingKey {
    case id = "productId"
    case isFavorite
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
  }
}

extension InterestWhetherDTO {
  func toEntity() -> InterestWhether {
    return InterestWhether(id: id, favorite: isFavorite)
  }
}
