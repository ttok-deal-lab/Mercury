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
    guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
      return nil
    }
    let filePath = URL(filePath: path)
    
    return filePath.appendingPathComponent(url.lastPathComponent).path()
  }
  
  func loadImage(_ url: URL) -> UIImage? {
    print("🔍 Attempting to load image from disk: \(url)")
    guard let path = filePath(for: url) else {
      return nil
    }
    
    let fileExists = fm.fileExists(atPath: path)
    
    if fileExists {
      if let image = UIImage(contentsOfFile: path) {
        print("✅ Successfully loaded image from disk")
        return image
      } else {
        // 해당 경로로 들어오거나 생성된 루트 삭제
        try? fm.removeItem(atPath: path)
        print("🗑️ Removed corrupted file")
      }
    }
    return nil
  }
  
  
  func saveImage(_ image: UIImage, _ url: URL, _ option: CacheOption) {
    guard option != .onlyMemory else { return }
    guard let path = filePath(for: url),
          !fm.fileExists(atPath: path) else { return }
    print("returning filePath: \(path)")
    
    // JPEG 저장 (원글도 JPEG 사용)
    let createFile = fm.createFile(atPath: path,
                                   contents: image.jpegData(compressionQuality: 1.0), // 임시
                                   attributes: nil)
    
    if createFile {
      print("✅ save Image to Disk:", path)  // 성공일 때만 로그
    } else {
      print("❌ save failed (createFile returned false):", path)
    }
  }
}
