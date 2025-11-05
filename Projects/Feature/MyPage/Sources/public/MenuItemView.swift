//
//  MenuItemView.swift
//  MyPage
//
//  Created by 최수훈 on 11/5/25.
//

import SwiftUI

struct MenuItemView<RightContent: View>: View {
  
  private let items: [String]
  private let icons: [Image]?
  private let rightView: RightContent
  private let onTap: () -> Void
  
  init(
    items: [String],
    icons: [Image]? = nil,
    @ViewBuilder rightView: () -> RightContent = { EmptyView() },
    _ onTap: @escaping () -> Void
  ) {
    self.items = items
    self.icons = icons
    self.rightView = rightView()
    self.onTap = onTap
  }
  
  var body: some View {
    ForEach(items, id: \.self) { item in
      HStack {
        Label {
          Text(item)
        } icon: {
          if let icons = icons,
             let index = items.firstIndex(of: item) {
            icons[index]
          }
        }
        Spacer()
        rightView
      }
      .contentShape(Rectangle())
      .onTapGesture {
        onTap()
      }
    }
    
  }
}

extension MenuItemView where RightContent == EmptyView {
  init(
    items: [String],
    icons: [Image]? = nil,
    _ onTap: @escaping () -> Void
  ) {
    self.items = items
    self.icons = icons
    self.rightView = EmptyView()
    self.onTap = onTap
  }
}
