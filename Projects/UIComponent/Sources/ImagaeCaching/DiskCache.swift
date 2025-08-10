//
//  DiskCache.swift
//  UIComponent
//
//  Created by 최수훈 on 8/10/25.
//

import UIKit

final class DiskCache: Cacheable {
  
  static let shared = DiskCache()
  private let fm = FileManager.default
  private init() {}
  
  private func filePath(for url: URL) -> String? {
    let key = convertToKey(from: url)
    let cachesURL = try? fm.url(for: .cachesDirectory,
                                in: .userDomainMask,
                                appropriateFor: nil,
                                create: true)
    return cachesURL?.appendingPathComponent(key).path
  }
  
  func loadImage(_ url: URL) -> UIImage? {
        guard let path = filePath(for: url),
              fm.fileExists(atPath: path) else { return nil }
        return UIImage(contentsOfFile: path)
    }
  
  func saveImage(_ image: UIImage, _ url: URL, _ option: CacheOption) {
          guard option != .onlyMemory && option != .nothing else { return }
          guard let path = filePath(for: url),
                !fm.fileExists(atPath: path) else { return }

          // JPEG 저장 (원글도 JPEG 사용)
          _ = fm.createFile(atPath: path,
                            contents: image.jpegData(compressionQuality: 1.0), // 임시
                            attributes: nil)
      }
}
