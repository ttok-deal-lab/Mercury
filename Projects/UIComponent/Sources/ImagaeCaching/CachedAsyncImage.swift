//
//  CachedAsyncImage.swift
//  UIComponent
//
//  Created by 최수훈 on 8/10/25.
//
import SwiftUI

public struct CachedAsyncImage<Placeholder: View, Content: View>: View {
  private let url: URL?
  private let option: CacheOption
  private let content: (Image) -> Content
  private let placeholder: () -> Placeholder
  
  @State private var uiImage: UIImage?
  @State private var isLoading = false
  @State private var loadPhase: AsyncImagePhase = .empty
  
  public init(
    url: URL?,
    option: CacheOption = .both,
    @ViewBuilder content: @escaping (Image) -> Content,
    @ViewBuilder placeholder: @escaping () -> Placeholder
  ) {
    self.url = url
    self.option = option
    self.content = content
    self.placeholder = placeholder
  }
  
  @Environment(\.imageCache) private var cache
  
  public var body: some View {
      switch loadPhase {
      case .empty:
        placeholder()
          .task {
            await loadImageWithCache()
          }
      case .success(let image):
        content(image)
          .transition(.opacity)
      case .failure(_):
        AsyncImage(url: url) { phase in
          switch phase {
          case .empty:
            placeholder()
          case .success(let image):
            content(image)
          case .failure(_):
            placeholder()
          @unknown default:
            placeholder()
          }

        }
      @unknown default:
        placeholder()
      }
  }
  
  private func loadImageWithCache() async {
    guard !isLoading, let url else {
      loadPhase = .empty
      return
    }
    isLoading = true
    defer { isLoading = false }
    if let cachedImage = await cache.loadImageOrDownload(url, option) {
      uiImage = cachedImage
      loadPhase = .success(Image(uiImage: cachedImage))
    } else {
      loadPhase = .failure(ImageLoadError.networkError)
    }
  }
}

