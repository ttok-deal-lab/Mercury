//
//  SalesPictureDTO.swift
//  Infrastructure
//
//  Created by 송하민 on 11/2/25.
//

import Foundation

import Domain

struct SalesPictureDTO: Decodable, Sendable {
  let sequence: Int
  let imageUrl: String
  
  func toEntity() -> SalesPicture {
    return .init(
      sequence: sequence,
      url: URL(string: imageUrl)
    )
  }
}
