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

  @State private var selection: Int = 1
  @State private var isReady: Bool = false

  private var wrapped: [Item] {
    guard let first = items.first, let last = items.last else { return items }
    return [last] + items + [first]
  }

  private func realToWrapped(_ idx: Int) -> Int {
    idx + 1
  }
  
  private func wrappedToReal(_ sel: Int) -> Int {
    if sel == 0 {
      return items.count - 1
    }
    if sel == items.count + 1 {
      return 0
    }
    return sel - 1
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
    TabView(selection: $selection) {
      ForEach(Array(wrapped.enumerated()), id: \.offset) { i, item in
        content(item)
          .tag(i)
          .containerRelativeFrame(.horizontal)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .contentShape(Rectangle())
      }
    }
    .tabViewStyle(.page(indexDisplayMode: .never))
    .onAppear {
      guard !isReady, !items.isEmpty else { return }
      isReady = true
      selection = realToWrapped(index.clamped(to: 0...(items.count - 1)))
    }
    .onChange(of: index) { _, newValue in
      guard !items.isEmpty else { return }
      withAnimation(.snappy) {
        selection = realToWrapped(newValue.clamped(to: 0...(items.count - 1)))
      }
    }
    .onChange(of: selection) { _, newSelection in
      guard !items.isEmpty else { return }
      let newReal = wrappedToReal(newSelection)
      if index != newReal { index = newReal }

      if newSelection == 0 {
        withTransaction(Transaction(animation: nil)) {
          selection = items.count
        }
      } else if newSelection == items.count + 1 {
        withTransaction(Transaction(animation: nil)) {
          selection = 1
        }
      }
    }
    .overlay(alignment: .bottomTrailing) {
      if showsIndicator, items.count > 1 {
        PageIndicator(totalCount: items.count, index: $selection)
          .padding(.horizontal, 12)
          .padding(.vertical, 14)
      }
    }
  }
}

private struct PageIndicator: View {
  let totalCount: Int
  @Binding var index: Int
  
  var body: some View {
    HStack(spacing: .zero) {
      Text("\(index)")
        .fonts(.bodyMiniBold)
        .foregroundStyle(.white)
      Text("/ \(totalCount)")
        .fonts(.bodyMiniBold)
        .foregroundStyle(.white.opacity(0.5))
    }
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
