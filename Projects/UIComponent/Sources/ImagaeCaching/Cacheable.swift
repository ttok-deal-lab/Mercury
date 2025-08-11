//
//  Cacheable.swift
//  UIComponent
//
//  Created by 최수훈 on 8/8/25.
//

import Foundation
import UIKit
import CryptoKit

protocol Cacheable {
  func convertToKey(from url: URL) -> String
}

// URL Unique화
extension Cacheable {
  func convertToKey(from url: URL) -> String {
    let data = Data(url.absoluteString.utf8)
    let digest = SHA256.hash(data: data)
    return digest.map { String(format: "%02x", $0) }.joined()
  }
}


