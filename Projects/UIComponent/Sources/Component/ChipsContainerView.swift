//
//  ChipsContainerView.swift
//  UIComponent
//
//  Created by 송하민 on 6/8/25.
//

import SwiftUI

public struct ChipsType: Hashable {
  public let id: String
  public let title: String
  public let priority: Int

  public init(id: String, title: String, priority: Int = 0) {
    self.id = id
    self.title = title
    self.priority = priority
  }
}

public struct ChipsView: View {
  private var title: String
  private var isSelected: Bool
  private let onTap: () -> Void
  
  public init(title: String, isSelected: Bool, onTap: @escaping () -> Void) {
    self.title = title
    self.isSelected = isSelected
    self.onTap = onTap
  }
  
  public var body: some View {
    Button {
      onTap()
    } label: {
      Text(title)
        .fonts(.bodySmallMedium)
        .foregroundColor(isSelected ? Asset.Colors.neutralWhite.color : Asset.Colors.neutral.color)
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(isSelected ? Asset.Colors.neutral.color : Asset.Colors.neutralWhite.color)
        .clipShape(Capsule())
        .overlay(
          Capsule()
            .stroke(Asset.Colors.gray150.color, lineWidth: 1)
        )
        .frame(height: 40)
    }
  }
}

public struct ChipsContainerView: View {
  @State var totalHeight: CGFloat
  @Binding var selectedChipIDs: Set<String>
  let verticalSpacing: CGFloat
  let horizontalSpacing: CGFloat
  let items: [ChipsType]

  var sortedItems: [ChipsType] { items.sorted { $0.priority < $1.priority } }

  public init(
    selectedChipIDs: Binding<Set<String>>,
    totalHeight: CGFloat = .zero,
    verticalSpacing: CGFloat = 8,
    horizontalSpacing: CGFloat = 8,
    items: [ChipsType]
  ) {
    self._selectedChipIDs = selectedChipIDs
    self.totalHeight = totalHeight
    self.verticalSpacing = verticalSpacing
    self.horizontalSpacing = horizontalSpacing
    self.items = items
  }

  public var body: some View {
    var width = CGFloat.zero
    var height = CGFloat.zero

    GeometryReader { geomety in
      ZStack(alignment: .topLeading) {
        ForEach(sortedItems, id: \.id) { item in
          ChipsView(
            title: item.title,
            isSelected: selectedChipIDs.contains(item.id),
            onTap: {
              if selectedChipIDs.contains(item.id) {
                selectedChipIDs.remove(item.id)
              } else {
                selectedChipIDs.insert(item.id)
              }
            }
          )
          .alignmentGuide(.leading) { view in
            if abs(width - view.width) > geomety.size.width {
              width = 0
              height -= view.height
              height -= verticalSpacing
            }
            let result = width
            if item == sortedItems.last {
              width = 0
            } else {
              width -= view.width
              width -= horizontalSpacing
            }
            return result
          }
          .alignmentGuide(.top) { _ in
            let result = height
            if item == sortedItems.last { height = 0 }
            return result
          }
        }
      }
      .background(
        GeometryReader { geometry in
          Color.clear.onAppear { totalHeight = geometry.size.height }
        }
      )
    }
    .frame(height: totalHeight)
    .padding(.vertical, 16)
    .padding(.horizontal, 20)
  }
}

