//
//  SearchNavigationBar.swift
//  Search
//
//  Created by 송하민 on 12/28/25.
//

import SwiftUI

import UIComponent

struct SearchNavigationBar: View {
  @Binding var text: String
  var onClose: () -> Void
  var onBack: () -> Void
  
  private let height: CGFloat = 42
  
  var body: some View {
    HStack(spacing: 8) {
      Button(action: onBack) {
        Asset.Images.arrowLeftNoShaft.image
          .resizable()
          .frame(width: 24, height: 24)
          .foregroundColor(Asset.Colors.neutral.color)
      }
      
      ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 8)
          .fill(Asset.Colors.neutralLight.color)
          .frame(height: height)
        
        if text.isEmpty {
          Text("\(L10n.searchPlaceholder1), \(L10n.searchPlaceholder2)")
            .fonts(.bodyMediumMedium)
            .foregroundColor(Asset.Colors.neutralSubtle.color)
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
        }
        
        TextField("", text: $text)
          .fonts(.bodyMediumMedium)
          .foregroundColor(Asset.Colors.neutral.color)
          .padding(.horizontal, 16)
          .frame(height: height)
      }
      
      Button(action: onClose) {
        Text("닫기")
          .fonts(.bodyMediumMedium)
          .foregroundColor(Asset.Colors.neutral.color)
      }
    }
    .padding(.horizontal, 12)
    .padding(.vertical, 9)
  }
}

#Preview {
  SearchNavigationBar(text: .constant("123")) {
    print("close")
  } onBack: {
    print("back")
  }
  
}
