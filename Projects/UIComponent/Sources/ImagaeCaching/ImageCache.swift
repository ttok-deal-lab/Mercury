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
  
  private init() {}
  
  public func loadImage(_ url: URL?,
                        _ option: CacheOption = .both) async -> UIImage? {
    guard let url else { return nil }
    // 1) Memory
    let key = convertToKey(from: url) as NSString
    if let img = memory.object(forKey: key) {
      
      return img
    }
    
    // 2) Disk (디스크 접근은 상대적으로 느리므로 백그라운드로)
    
    if let diskImage = await withCheckedContinuation({ (continuation: CheckedContinuation<UIImage?, Never>) in
      DispatchQueue.global(qos: .userInitiated).async {
        continuation.resume(returning: DiskCache.shared.loadImage(url))
      }
    }) {
      saveToMemory(diskImage, url, option)
       print("Load image from Disk")
      return diskImage
    }
    // 3) Network
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
  
  private func saveToMemory(_ image: UIImage, _ url: URL, _ option: CacheOption) {
    guard option != .onlyDisk && option != .nothing else { return }
    let key = convertToKey(from: url) as NSString
    memory.setObject(image, forKey: key)
  }
  
  public func removeAll() {
    memory.removeAllObjects()
    // 디스크 전체 삭제가 필요하면 DiskCache에 메서드 추가하세요.
  }
}
