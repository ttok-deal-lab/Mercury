//
//  ChipsContainerView.swift
//  UIComponent
//
//  Created by 송하민 on 6/8/25.
//

import SwiftUI

public struct ChipsType: Equatable {
  let title: String
  let priority: Int
  
  public init(
    title: String,
    priority: Int = 0
  ) {
    self.title = title
    self.priority = priority
  }
  
  public static func == (lhs: ChipsType, rhs: ChipsType) -> Bool {
    lhs.title == rhs.title
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
  @Binding var selectedChipTitles: Set<String>
  let verticalSpacing: CGFloat
  let horizontalSpacing: CGFloat
  let items: [ChipsType]
  var sortedItems: [ChipsType] {
    items.sorted(by: { $0.priority < $1.priority })
  }
  
  public init(
    selectedChipTitles: Binding<Set<String>>,
    totalHeight: CGFloat = .zero,
    verticalSpacing: CGFloat = 8,
    horizontalSpacing: CGFloat = 8,
    items: [ChipsType]
  ) {
    self._selectedChipTitles = selectedChipTitles
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
        ForEach(self.sortedItems, id: \.title) { item in
          ChipsView(title: item.title, isSelected: selectedChipTitles.contains(item.title), onTap: {
            if selectedChipTitles.contains(item.title) {
              selectedChipTitles.remove(item.title)
            } else {
              selectedChipTitles.insert(item.title)
            }
          })
          .id(item.title)
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
            
            if item == sortedItems.last {
              height = 0
            }
            return result
          }
        }
      }
      .background(
        GeometryReader { geometry in
          Color.clear
            .onAppear {
              self.totalHeight = geometry.size.height
            }
        }
      )
    }
    .frame(height: totalHeight)
    .padding(.vertical, 16)
    .padding(.horizontal, 20)
  }
}
