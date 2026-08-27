//
//  ImageLoadError.swift
//  UIComponent
//
//  Created by 최수훈 on 8/23/25.
//

import Foundation

public enum ImageLoadError: Error {
  case invalidData
  case networkError
  case cacheError
}
