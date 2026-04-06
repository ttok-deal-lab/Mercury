//
//  MercuryNavigationBar.swift
//  UIComponent
//
//  Created by 최수훈 on 11/1/25.
//

import SwiftUI

public struct MercuryNavigationBar<LeftContent: View, RightContent: View>: View {
  
  let title: String?
  let leftButtons: LeftContent
  let rightButtons: RightContent
  let titleFont: MercuryFont
  
  public init(
    _ title: String? = nil,
    titleFont: MercuryFont = .bodyLargeBold,
    @ViewBuilder leftButtons: () -> LeftContent = { EmptyView() },
    @ViewBuilder rightButtons: () -> RightContent = { EmptyView() }
  ) {
    self.title = title
    self.leftButtons = leftButtons()
    self.rightButtons = rightButtons()
    self.titleFont = titleFont
  }
  
  public var body: some View {
    ZStack {
      HStack(alignment: .center, spacing: 0) {
        leftButtons
          .frame(minWidth: 28, minHeight: 28)
          .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 12))
        
        if let title = title {
          Text(title)
            .fonts(titleFont)
            .foregroundStyle(.black)
            .lineLimit(1)
            .padding(.vertical, 16)
        } else {
          EmptyView()
        }
        
        Spacer()
        
        rightButtons
          .frame(minWidth: 28, minHeight: 28)
          .padding(.vertical, 16)
          .padding(.trailing, 20)
        
      } // HStack
      
    }
    .contentShape(Rectangle())
    .background(.white)
  }
}

extension MercuryNavigationBar where LeftContent == EmptyView {
  public init(
    _ title: String? = nil,
    titleFont: MercuryFont = .bodyLargeBold,
    @ViewBuilder rightButtons: () -> RightContent
  ) {
    self.title = title
    self.leftButtons = EmptyView()
    self.rightButtons = rightButtons()
    self.titleFont = titleFont
  }
}

extension MercuryNavigationBar where RightContent == EmptyView {
  public init(
    _ title: String? = nil,
    titleFont: MercuryFont = .bodyLargeBold,
    @ViewBuilder leftButtons: @escaping () -> LeftContent
  ) {
    self.title = title
    self.leftButtons = leftButtons()
    self.rightButtons = EmptyView()
    self.titleFont = titleFont
  }
}

extension MercuryNavigationBar where LeftContent == EmptyView, RightContent == EmptyView {
  public init(
  title: String? = nil,
  titleFont: MercuryFont = .bodyLargeBold
  ) {
    self.title = title
    self.leftButtons = EmptyView()
    self.rightButtons = EmptyView()
    self.titleFont = titleFont
  }
}

