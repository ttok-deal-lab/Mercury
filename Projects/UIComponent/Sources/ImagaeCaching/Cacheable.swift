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
  func convertToKey(from url: String) -> String
}

// URL Unique화
extension Cacheable {
  func convertToKey(from url: String) -> String {
    let urlKeyString =  url
    return urlKeyString
  }
}


