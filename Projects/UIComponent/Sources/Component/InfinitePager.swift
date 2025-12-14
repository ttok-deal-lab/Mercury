//
//  InfinitePager.swift
//  UIComponent
//
//  Created by 송하민 on 11/2/25.
//

import SwiftUI

public struct InfinitePager<Item, Content>: View where Item: Identifiable & Equatable, Content: View {

  @Binding private var index: Int

  private let items: [Item]
  private let content: (Item) -> Content
  private let spacing: CGFloat
  private let showsIndicator: Bool

  @State private var visibleID: Int? = nil
  @State private var isReady: Bool = false
  @State private var currentIndex: Int = 0

  private var wrapped: [Item] {
    guard let first = items.first, let last = items.last else { return items }
    return [last] + items + [first]
  }

  private func realToWrappedID(_ real: Int) -> Int { real + 1 }

  private func wrappedIDToReal(_ id: Int) -> Int {
    if id == 0 { return max(items.count - 1, 0) }
    if id == items.count + 1 { return 0 }
    return id - 1
  }

  public init(
    items: [Item],
    index: Binding<Int> = .constant(0),
    spacing: CGFloat = 0,
    showsIndicator: Bool = true,
    @ViewBuilder content: @escaping (Item) -> Content
  ) {
    self.items = items
    self._index = index
    self.spacing = spacing
    self.showsIndicator = showsIndicator
    self.content = content
  }

  public var body: some View {
    GeometryReader { _ in
      ScrollView(.horizontal) {
        LazyHStack(spacing: spacing) {
          ForEach(Array(wrapped.enumerated()), id: \.offset) { id, item in
            content(item)
              .frame(maxWidth: .infinity, maxHeight: .infinity)
              .containerRelativeFrame(.horizontal)
              .id(id)
              .contentShape(Rectangle())
          }
        }
        .scrollTargetLayout()
      }
      .scrollIndicators(.hidden)
      .scrollTargetBehavior(.paging)
      .scrollPosition(id: $visibleID, anchor: .center)
      .onAppear {
        guard !isReady else { return }
        isReady = true
        guard !items.isEmpty else { return }

        let clamped = index.clamped(to: 0...(items.count - 1))
        DispatchQueue.main.async {
          visibleID = realToWrappedID(clamped)
          currentIndex = clamped
        }
      }
      .onChange(of: index) { _, newValue in
        guard !items.isEmpty else { return }

        let clamped = newValue.clamped(to: 0...(items.count - 1))
        currentIndex = clamped
        let targetID = realToWrappedID(clamped)
        guard visibleID != targetID else { return }

        withAnimation(.snappy) {
          visibleID = targetID
        }
      }
      .onChange(of: visibleID) { _, newID in
        guard !items.isEmpty else { return }
        guard let newID else { return }

        let newReal = wrappedIDToReal(newID)
        if index != newReal {
          index = newReal
        }
        if currentIndex != newReal {
          currentIndex = newReal
        }

        if newID == 0 {
          let target = items.count
          DispatchQueue.main.async {
            withTransaction(Transaction(animation: nil)) {
              visibleID = target
            }
          }
        } else if newID == items.count + 1 {
          let target = 1
          DispatchQueue.main.async {
            withTransaction(Transaction(animation: nil)) {
              visibleID = target
            }
          }
        }
      }
      .overlay(alignment: .bottomTrailing) {
        if showsIndicator, items.count > 1 {
          PageIndicator(totalCount: items.count, realIndex: $currentIndex)
            .padding(.horizontal, 12)
            .padding(.vertical, 14)
        }
      }
    }
  }
}

private struct PageIndicator: View {
  let totalCount: Int
  @Binding var realIndex: Int

  var body: some View {
    HStack(spacing: 0) {
      Text("\(realIndex + 1)")
        .foregroundStyle(.white)
      Text("/ \(totalCount)")
        .foregroundStyle(.white.opacity(0.5))
    }
    .font(.system(size: 12, weight: .semibold))
    .padding(.horizontal, 10)
    .padding(.vertical, 5)
    .frame(height: 24)
    .background(.black.opacity(0.4), in: Capsule())
  }
}

private extension Comparable {
  func clamped(to range: ClosedRange<Self>) -> Self {
    min(max(self, range.lowerBound), range.upperBound)
  }
}
