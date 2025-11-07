//
//  MercuryMenuItemView.swift
//  MyPage
//
//  Created by 최수훈 on 11/5/25.
//

import SwiftUI

import UIComponent

public enum MenuItemType {
  case iconLabel
  case textLabel
  case description
}

public struct MercuryMenuItemView<RightContent: View>: View {
  
  private let item: String
  private let icon: Image?
  private let description: String?
  private let rightLabel: String?
  private let rightView: RightContent
  private let left: MenuItemType
  private var onTap: () -> Void
  
  public init(
    item: String,
    icon: Image? = nil,
    description: String? = nil,
    rightLabel: String? = nil,
    left: MenuItemType,
    @ViewBuilder rightView: () -> RightContent = { EmptyView() },
    onTap: @escaping () -> Void
  ) {
    self.item = item
    self.icon = icon
    self.description = description
    self.rightLabel = rightLabel
    self.rightView = rightView()
    self.left = left
    self.onTap = onTap
  }
  
  public var body: some View {
    HStack {
      switch left {
      case .iconLabel:
        Label {
          Text(item)
        } icon: {
          if let icon = icon {
            icon
          }
        }
        
      case .textLabel:
        Text(item)
      case .description:
        VStack(spacing: 0) {
          Text(item)
            .padding(.bottom, 4)
          if let description = description {
            Text(description)
              .fonts(.bodyMiniMedium)
              .foregroundStyle(Asset.Colors.neutralSubtler.color)
          }
        }
      }
      
      Spacer()
      
      if let labelString = rightLabel {
        Text(labelString)
          .fonts(.bodyMediumRegular)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)
      }
      
      rightView
    }
    .padding(20)
    .contentShape(Rectangle())
    .background(.white)
    .onTapGesture {
      onTap()
    }
  }
}
