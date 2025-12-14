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
  
  @State private var selectedURL: URL? = nil
  
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
        selectedURL = item.url
      }
    }
    .frame(height: height)
    .fullScreenCover(item: $selectedURL) { url in
      ZoomableAsyncImage(url: url) {
        selectedURL = nil
      }
    }
  }
}

private struct ZoomableAsyncImage: View {
  let url: URL
  var onClose: () -> Void

  @State private var scale: CGFloat = 1.0
  @State private var lastScale: CGFloat = 1.0
  @State private var offset: CGSize = .zero
  @State private var lastOffset: CGSize = .zero

  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()

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
            .gesture(drag)
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
        ZStack { Color.black.ignoresSafeArea(); ProgressView().tint(.white) }
      }
    }
    .overlay(alignment: .topTrailing) {
      Button(action: {
        onClose()
      }) {
        Image(systemName: "xmark.circle.fill")
          .font(.system(size: 28))
          .foregroundStyle(.white.opacity(0.9))
          .padding(16)
      }
      .accessibilityLabel("Close")
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

extension URL: @retroactive Identifiable {
  public var id: String { absoluteString }
}
