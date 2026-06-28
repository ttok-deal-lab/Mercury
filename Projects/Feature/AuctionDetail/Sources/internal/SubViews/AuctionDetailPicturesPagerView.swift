//
//  AuctionDetailPicturesPagerView.swift
//  Auction
//
//  Created by 송하민 on 11/2/25.
//

import SwiftUI

import UIComponent
import Domain

struct AuctionDetailPicturesPagerView: View {
  let height: CGFloat
  let auctionDetailInfo: AuctionDetail

  @State private var gallery: GalleryPresentation? = nil

  private var pictureURLs: [URL] {
    auctionDetailInfo.salesPictures.compactMap(\.url)
  }

  var body: some View {
    InfinitePager(items: auctionDetailInfo.salesPictures) { item in
      CachedAsyncImage(url: item.url) { image in
        image.resizable()
      } placeholder: {
        Color.gray
      }
      .frame(maxWidth: .infinity)
      .contentShape(Rectangle())
      .onTapGesture {
        guard let url = item.url,
              let index = pictureURLs.firstIndex(of: url) else { return }
        gallery = GalleryPresentation(startIndex: index)
      }
    }
    .frame(height: height)
    .fullScreenCover(item: $gallery) { presentation in
      ZoomableImageGallery(urls: pictureURLs, startIndex: presentation.startIndex) {
        gallery = nil
      }
    }
  }
}

// MARK: - Gallery Presentation

private struct GalleryPresentation: Identifiable {
  let startIndex: Int
  var id: Int { startIndex }
}

// MARK: - Zoomable Gallery (가로 슬라이딩 페이지네이션)

private struct ZoomableImageGallery: View {
  let urls: [URL]
  var onClose: () -> Void

  @State private var selectedIndex: Int

  init(urls: [URL], startIndex: Int, onClose: @escaping () -> Void) {
    self.urls = urls
    self.onClose = onClose
    self._selectedIndex = State(initialValue: startIndex)
  }

  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()

      TabView(selection: $selectedIndex) {
        ForEach(Array(urls.enumerated()), id: \.offset) { index, url in
          ZoomablePage(url: url)
            .tag(index)
        }
      }
      .tabViewStyle(.page(indexDisplayMode: .never))
      .ignoresSafeArea()
    }
    .overlay(alignment: .topTrailing) {
      Button(action: onClose) {
        Image(systemName: "xmark.circle.fill")
          .font(.system(size: 28))
          .foregroundStyle(.white.opacity(0.9))
          .padding(16)
      }
      .accessibilityLabel("Close")
    }
    .overlay(alignment: .bottom) {
      if urls.count > 1 {
        Text("\(selectedIndex + 1) / \(urls.count)")
          .font(.system(size: 13, weight: .semibold))
          .foregroundStyle(.white)
          .padding(.horizontal, 12)
          .padding(.vertical, 6)
          .background(.black.opacity(0.4), in: Capsule())
          .padding(.bottom, 24)
      }
    }
  }
}

// MARK: - Single Zoomable Page

private struct ZoomablePage: View {
  let url: URL

  @State private var scale: CGFloat = 1.0
  @State private var lastScale: CGFloat = 1.0
  @State private var offset: CGSize = .zero
  @State private var lastOffset: CGSize = .zero

  var body: some View {
    CachedAsyncImage(url: url) { image in
      GeometryReader { proxy in
        let size = proxy.size
        image
          .resizable()
          .scaledToFit()
          .frame(width: size.width, height: size.height)
          .scaleEffect(scale)
          .offset(offset)
          .gesture(magnification)
          // 확대 상태에서만 패닝 제스처를 활성화해, 기본 배율에서는 TabView 가로 슬라이딩이 동작하도록 한다.
          .gesture(drag, including: scale > 1.0 ? .all : .subviews)
          .onTapGesture(count: 2) {
            withAnimation(.spring) {
              if scale > 1.01 {
                scale = 1.0
                offset = .zero
              } else {
                scale = 2.0
              }
            }
          }
          .animation(.snappy, value: scale)
          .animation(.snappy, value: offset)
      }
    } placeholder: {
      ZStack { Color.black; ProgressView().tint(.white) }
    }
    .onChange(of: scale) { _, newScale in
      // Clamp scale and adjust offset when scale returns to 1
      let clamped = min(max(newScale, 1.0), 4.0)
      if clamped != scale {
        scale = clamped
      }
      if clamped <= 1.0 {
        offset = .zero
        lastOffset = .zero
      }
    }
  }

  private var magnification: some Gesture {
    MagnificationGesture()
      .onChanged { value in
        let delta = value / lastScale
        scale *= delta
        lastScale = value
      }
      .onEnded { _ in
        lastScale = 1.0
        if scale > 4.0 {
          withAnimation(.spring) { scale = 4.0 }
        }
        if scale < 1.0 {
          withAnimation(.spring) { scale = 1.0; offset = .zero; lastOffset = .zero }
        }
      }
  }

  private var drag: some Gesture {
    DragGesture()
      .onChanged { value in
        guard scale > 1.0 else { return }
        offset = CGSize(width: lastOffset.width + value.translation.width,
                        height: lastOffset.height + value.translation.height)
      }
      .onEnded { _ in
        lastOffset = offset
      }
  }
}
