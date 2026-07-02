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
    }
    
    let fallbackFormats = [
      "yyyy-MM-dd'T'HH:mm:ss",
      "yyyy-MM-dd"
    ]
    
    for format in fallbackFormats {
      let formatter = DateFormatter()
      formatter.dateFormat = format
      formatter.locale = Locale(identifier: "en_US_POSIX")
      formatter.timeZone = TimeZone(secondsFromGMT: 0)
      
      if let date = formatter.date(from: string) {
        return date
      }
    }
    throw DecodingError.dataCorruptedError(
      forKey: key,
      in: container,
      debugDescription: "Unrecognized date format: \(string)"
    )
  }
}
