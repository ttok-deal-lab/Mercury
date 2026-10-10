//
//  CrewLeaderFormSectionView.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import SwiftUI

import UIComponent

struct CrewLeaderFormSectionView<Content: View>: View {
  
  private let title: String
  private let isRequired: Bool
  private let description: String?
  private let content: Content
  
  init(
    title: String,
    isRequired: Bool = false,
    description: String? = nil,
    @ViewBuilder content: () -> Content
  ) {
    self.title = title
    self.isRequired = isRequired
    self.description = description
    self.content = content()
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack(alignment: .top, spacing: 2) {
        Text(title)
          .fonts(.bodyMicroBold)
          .foregroundStyle(Asset.Colors.neutral.color)
        
        if isRequired {
          Text("*")
            .fonts(.bodyMicroBold)
            .foregroundStyle(Asset.Colors.critical.color)
        }
      }
      
      if let description {
        Text(description)
          .fonts(.bodyMicroRegular)
          .foregroundStyle(Asset.Colors.neutralSubtle.color)
      }
      
      content
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
}
