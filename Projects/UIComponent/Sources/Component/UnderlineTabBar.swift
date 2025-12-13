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
          VStack(spacing: 8) {
            Text(title(tab))
              .font(.system(size: 15, weight: selected == tab ? .semibold : .regular))
              .foregroundStyle(selected == tab ? Color.blue : Color.gray)

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
        }
        .buttonStyle(.plain)
      }
      Spacer(minLength: 0)
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 10)
  }
}

public struct TabPager<Tab: Identifiable & Hashable, Page: View>: View {
  public let tabs: [Tab]
  @Binding public var selected: Tab
  public let page: (Tab) -> Page
  public let spacing: CGFloat

  @State private var visibleID: Tab.ID?
  @State private var isReady = false

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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .containerRelativeFrame(.horizontal)
            .id(tab.id)
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
      DispatchQueue.main.async {
        visibleID = selected.id
      }
    }
    .onChange(of: selected) { _, newSelected in
      guard visibleID != newSelected.id else { return }
      withAnimation(.snappy) {
        visibleID = newSelected.id
      }
    }
    .onChange(of: visibleID) { _, newID in
      guard let newID else { return }
      guard let newSelected = tabs.first(where: { $0.id == newID }) else { return }
      if selected != newSelected {
        selected = newSelected
      }
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
