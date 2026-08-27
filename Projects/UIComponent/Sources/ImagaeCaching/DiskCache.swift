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
  
  private let maxCacheSize: Int = 100 * 1024 * 1024
  private let maxCacheAge: TimeInterval = 7 * 24 * 60 * 60
  private init() {
    Task {
      await cleanUpExpiredFiles()
    }
  }
  
  private func filePath(for url: URL) -> String? {
    guard let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else { return nil }
    
    return cacheURL.appendingPathComponent(url.lastPathComponent).path()
  }
  
  private func cacheDirectoryPath() -> String? {
    return FileManager.default.urls(for: .cachesDirectory,
                                    in: .userDomainMask).first?.path()
  }
  
  func loadImage(_ url: URL) -> UIImage? {
    guard let path = filePath(for: url) else {
      return nil
    }
    
    let fileExists = fm.fileExists(atPath: path)
    
    if fileExists {
      updateFileAccessTime(at: path)
      if let image = UIImage(contentsOfFile: path) {
        return image
      } else {
        try? fm.removeItem(atPath: path)
        return nil
      }
    }
    return nil
  }
  
  
  func saveImage(_ image: UIImage, _ url: URL, _ option: CacheOption) {
    guard option != .onlyMemory else { return }
    guard let path = filePath(for: url),
          !fm.fileExists(atPath: path) else { return }
    
    Task {
      await saveImageToDisk(image, at: path, url: url)
    }
  }
  
  private func saveImageToDisk(_ image: UIImage, at path: String, url: URL) async {
    // JPEG 저장
    let createFile = fm.createFile(atPath: path,
                                   contents: image.jpegData(compressionQuality: 1.0), // 임시
                                   attributes: nil)
    
    if createFile {
      Task {
        await checkCacheSizeAndCleanUp()
      }
    } else {
    }
  }
  
  private func updateFileAccessTime(at path: String) {
    let now = Date()
    try? fm.setAttributes([.modificationDate: now], ofItemAtPath: path)
  }
  
  private func checkCacheSizeAndCleanUp() async {
    guard let cacheDir = cacheDirectoryPath() else { return }
    
    do {
      let files = try fm.contentsOfDirectory(atPath: cacheDir)
      var fileInfos: [(path: String, size: Int, date: Date)] = []
      var totalSize = 0
      
      for file in files {
        let fullPath = (cacheDir as NSString).appendingPathComponent(file)
        let attributes = try fm.attributesOfItem(atPath: fullPath)
        
        if let size = attributes[.size] as? Int,
           let date = attributes[.modificationDate] as? Date {
          fileInfos.append((path: fullPath, size: size, date: date))
          totalSize += size
        }
      }
      
      if totalSize > maxCacheSize {
        fileInfos.sort { $0.date < $1.date }
        
        //60% 까지 줄이기
        let targetSize = maxCacheSize * 6 / 10
        var currentSize = totalSize
        
        for fileInfo in fileInfos {
          if currentSize <= targetSize {
            break
          }
          
          try? fm.removeItem(atPath: fileInfo.path)
          currentSize -= fileInfo.size
        }
      }
    } catch {
    }
  }
  
  private func cleanUpExpiredFiles() async {
    guard let cacheDir = cacheDirectoryPath() else { return }
    
    do {
      let files = try fm.contentsOfDirectory(atPath: cacheDir)
      let now = Date()
      
      for file in files {
        let fullPath = (cacheDir as NSString).appendingPathComponent(file)
        let attributes = try fm.attributesOfItem(atPath: fullPath)
        
        if let date = attributes[.modificationDate] as? Date {
          let age = now.timeIntervalSince(date)
          if age > maxCacheAge {
            try fm.removeItem(atPath: fullPath)

          }
        }
      }
    } catch {
    }
  }
}
