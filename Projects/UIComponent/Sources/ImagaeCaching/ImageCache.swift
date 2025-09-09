//
//  ImageCache.swift
//  UIComponent
//
//  Created by 최수훈 on 8/10/25.
//

import UIKit

public final class ImageCache: Cacheable {
  public static let shared = ImageCache()
  private let memory = NSCache<NSString, UIImage>()
  
  private init() {
    // 최대 100개 이미지
    memory.countLimit = 100
    // 50MB
    memory.totalCostLimit = 50 * 1024 * 1024
  }
  
  public func loadImageOrDownload(_ url: URL?, _ option: CacheOption = .both) async -> UIImage? {
    guard let url = url else { return nil }
    if let cachedImage = await loadImage(url, option) {
      return cachedImage
    }
    return await downloadAndSave(url, option)
  }
  
  public func loadImage(_ url: URL?, _ option: CacheOption = .both) async -> UIImage? {
    guard let url else { return nil }
    // 1. Memory
    if option != .onlyDisk {
      let key = convertToKey(from: url.absoluteString) as NSString
      if let img = memory.object(forKey: key) {
        print("Load Image from Memory")
        return img
      }
    }
    
    // 2. Disk (디스크 접근은 상대적으로 느리므로 백그라운드로)
    if let diskImage = await withCheckedContinuation({ (continuation: CheckedContinuation<UIImage?, Never>) in
      DispatchQueue.global(qos: .userInitiated).async {
        continuation.resume(returning: DiskCache.shared.loadImage(url))
      }
    }) {
      saveToMemory(diskImage, url, option)
      print("Load image from Disk")
      return diskImage
    }
    return nil
    
  }
  
  private func downloadAndSave(_ url: URL, _ option: CacheOption) async -> UIImage? {
    
    // 3. Network
    do {
        let (data, _) = try await URLSession.shared.data(from: url)
        if let image = UIImage(data: data) {
          saveToMemory(image, url, option)
          await withCheckedContinuation { (continuation: CheckedContinuation<Void, Never>) in
            DispatchQueue.global(qos: .utility).async {
              DiskCache.shared.saveImage(image, url, option)
              continuation.resume()
            }
          }
          print("Download the image.")
          return image
        } else {
          print("Invalid image data.")
          return nil
        }
      } catch {
        print("Network error: \(error)")
        return nil
      }

  }
  
  private func saveImage(_ image: UIImage, url: URL, option: CacheOption) async {
    saveToMemory(image, url, option)

    if option != .onlyMemory {
      Task.detached(priority: .utility) {
        DiskCache.shared.saveImage(image, url, option)
      }
    }
  }
  
  private func saveToMemory(_ image: UIImage, _ url: URL, _ option: CacheOption) {
    guard option != .onlyDisk else { return }
    let key = convertToKey(from: url.absoluteString) as NSString
    memory.setObject(image, forKey: key)
    print("Save image to memory")
  }
  
  // 사용 X
  public func removeAll() {
    memory.removeAllObjects()
  }
}
