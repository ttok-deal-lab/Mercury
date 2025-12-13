//
//  UnderlineTabBar.swift
//  UIComponent
//
//  Created by 송하민 on 12/13/25.
//

import SwiftUI

public struct UnderlineTabBar<Tab: Identifiable & Hashable>: View {
  public let tabs: [Tab]
  @Binding public var selected: Tab
  public let title: (Tab) -> String

  @Namespace private var ns

  public init(
    tabs: [Tab],
    selected: Binding<Tab>,
    title: @escaping (Tab) -> String
  ) {
    self.tabs = tabs
    self._selected = selected
    self.title = title
  }

  public var body: some View {
    HStack(spacing: 20) {
      ForEach(tabs) { tab in
        Button {
          withAnimation(.snappy) { selected = tab }
        } label: {
          VStack(spacing: .zero) {
            Text(title(tab))
              .fonts(.bodyLargeBold)
              .foregroundStyle(selected == tab ? Asset.Colors.primary.color : Asset.Colors.neutralSubtler.color)
              .fixedSize(horizontal: true, vertical: false)
              .frame(height: 48)

            ZStack {
              if selected == tab {
                Rectangle()
                  .fill(Color.blue)
                  .frame(height: 2)
                  .matchedGeometryEffect(id: "underline", in: ns)
              } else {
                Color.clear.frame(height: 2)
              }
            }
          }
          .fixedSize(horizontal: true, vertical: false)
          .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
      }
      Spacer()
    }
    .padding(.horizontal, 20)
    .overlay(alignment: .bottom) {
      Asset.Colors.gray150.color
        .frame(height: 1)
    }
  }
}

public struct TabPager<Tab: Identifiable & Hashable, Page: View>: View {
  public let tabs: [Tab]
  @Binding public var selected: Tab
  public let page: (Tab) -> Page
  public let spacing: CGFloat

  @State private var visibleID: Tab.ID?
  @State private var isReady = false

  @State private var pageHeights: [Tab.ID: CGFloat] = [:]
  @State private var currentHeight: CGFloat = 0

  public init(
    tabs: [Tab],
    selected: Binding<Tab>,
    spacing: CGFloat = 0,
    @ViewBuilder page: @escaping (Tab) -> Page
  ) {
    self.tabs = tabs
    self._selected = selected
    self.spacing = spacing
    self.page = page
  }

  public var body: some View {
    ScrollView(.horizontal) {
      LazyHStack(spacing: spacing) {
        ForEach(tabs) { tab in
          page(tab)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .fixedSize(horizontal: false, vertical: true)
            .background(PageHeightReporter(id: tab.id))
            .containerRelativeFrame(.horizontal)
            .id(tab.id)
            .contentShape(Rectangle())
        }
      }
      .scrollTargetLayout()
    }
    .scrollIndicators(.hidden)
    .scrollTargetBehavior(.paging)
    .scrollPosition(id: $visibleID, anchor: .top)
    .frame(height: max(1, currentHeight), alignment: .top)
    .clipped()
    .onAppear {
      guard !isReady else { return }
      isReady = true
      DispatchQueue.main.async {
        visibleID = selected.id
      }
    }
    .onChange(of: selected) { _, newSelected in
      guard visibleID != newSelected.id else { return }
      withAnimation(.snappy) {
        visibleID = newSelected.id
      }
      updateHeight(for: newSelected.id, animated: true)
    }
    .onChange(of: visibleID) { _, newID in
      guard let newID else { return }
      guard let newSelected = tabs.first(where: { $0.id == newID }) else { return }
      if selected != newSelected {
        selected = newSelected
      }
      updateHeight(for: newID, animated: true)
    }
    .onPreferenceChange(PageHeightPreferenceKey<Tab.ID>.self) { new in
      pageHeights.merge(new, uniquingKeysWith: { $1 })
      updateHeight(for: selected.id, animated: false)
    }
  }

  private func updateHeight(for id: Tab.ID, animated: Bool) {
    guard let h = pageHeights[id], h > 0 else { return }
    if animated {
      withAnimation(.snappy) { currentHeight = h }
    } else {
      currentHeight = h
    }
  }
}

public struct UnderlineTabPager<Tab: Identifiable & Hashable, Page: View>: View {
  public let tabs: [Tab]
  @Binding public var selected: Tab
  public let title: (Tab) -> String
  public let spacing: CGFloat
  public let page: (Tab) -> Page

  public init(
    tabs: [Tab],
    selected: Binding<Tab>,
    spacing: CGFloat = 0,
    title: @escaping (Tab) -> String,
    @ViewBuilder page: @escaping (Tab) -> Page
  ) {
    self.tabs = tabs
    self._selected = selected
    self.spacing = spacing
    self.title = title
    self.page = page
  }

  public var body: some View {
    VStack(spacing: 0) {
      UnderlineTabBar(tabs: tabs, selected: $selected, title: title)
      TabPager(tabs: tabs, selected: $selected, spacing: spacing, page: page)
    }
  }
  
}


private struct PageHeightPreferenceKey<ID: Hashable>: PreferenceKey {
  static var defaultValue: [ID: CGFloat] { [:] }
  static func reduce(value: inout [ID: CGFloat], nextValue: () -> [ID: CGFloat]) {
    value.merge(nextValue(), uniquingKeysWith: { $1 })
  }
}

private struct PageHeightReporter<ID: Hashable>: View {
  let id: ID

  var body: some View {
    GeometryReader { proxy in
      Color.clear
        .preference(key: PageHeightPreferenceKey<ID>.self, value: [id: proxy.size.height])
    }
  }
}
