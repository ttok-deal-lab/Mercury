//
//  ImageCacheKey.swift
//  UIComponent
//
//  Created by 최수훈 on 8/10/25.
//

import SwiftUI

private struct ImageCacheKey: EnvironmentKey {
  static let defaultValue: ImageCache = .shared
}

public extension EnvironmentValues {
  var imageCache: ImageCache {
    get { self[ImageCacheKey.self] }
    set { self[ImageCacheKey.self] = newValue }
  }
}
