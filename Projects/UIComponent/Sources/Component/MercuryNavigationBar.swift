//
//  MercuryNavigationBar.swift
//  UIComponent
//
//  Created by 최수훈 on 11/1/25.
//

import SwiftUI

public struct MercuryNavigationBar<LeftContent: View, RightContent: View>: View {
  
  let title: Text?
  let leftButtons: LeftContent
  let rightButtons: RightContent
  
  public init(
    _ title: Text? = nil,
    @ViewBuilder leftButtons: () -> LeftContent = { EmptyView() },
    @ViewBuilder rightButtons: () -> RightContent = { EmptyView() }
  ) {
    self.title = title
    self.leftButtons = leftButtons()
    self.rightButtons = rightButtons()
  }
  
  public var body: some View {
    ZStack {
      HStack(alignment: .center, spacing: 0) {
        leftButtons
          .frame(minWidth: 28, minHeight: 28)
          .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 0))
        
        Spacer()
        
        rightButtons
          .frame(minWidth: 28, minHeight: 28)
          .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 20))
        
      } // HStack
      
      if title == nil {
        EmptyView()
      } else {
        title
        .lineLimit(1)
        .padding(30)
      }
    }
  }
}

extension MercuryNavigationBar where LeftContent == EmptyView {
  public init(
    _ title: Text?,
    @ViewBuilder rightButtons: () -> RightContent
  ) {
    self.title = title
    self.leftButtons = EmptyView()
    self.rightButtons = rightButtons()
  }
}

extension MercuryNavigationBar where RightContent == EmptyView {
  public init(
    _ title: Text?,
    @ViewBuilder leftButtons: () -> LeftContent
  ) {
    self.title = title
    self.leftButtons = leftButtons()
    self.rightButtons = EmptyView()
  }
}

