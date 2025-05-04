//
//  ISO8601DateFormatterExtension.swift
//  Infrastructure
//
//  Created by 송하민 on 5/4/25.
//

import Foundation

extension ISO8601DateFormatter {
  func decode<Key: CodingKey>(from container: KeyedDecodingContainer<Key>, key: Key) throws -> Date {
    let string = try container.decode(String.self, forKey: key)
    if let date = self.date(from: string) {
      return date
    } else {
      throw DecodingError.dataCorruptedError(forKey: key, in: container, debugDescription: "Invalid date format: \(string)")
    }
  }
}
