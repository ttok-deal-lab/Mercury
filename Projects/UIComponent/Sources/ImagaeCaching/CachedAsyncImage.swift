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
        Group {
            if let uiImage {
              content(Image(uiImage: uiImage))
                    .transition(.opacity)
            } else {
                placeholder()
                    .task {
                        await load()
                    }
            }
        }
        .onChange(of: url) { _ in
            uiImage = nil
            Task { await load() }
        }
    }

    private func load() async {
        guard !isLoading, let url else { return }
        isLoading = true
        defer { isLoading = false }
        uiImage = await cache.loadImage(url, option)
    }
}

