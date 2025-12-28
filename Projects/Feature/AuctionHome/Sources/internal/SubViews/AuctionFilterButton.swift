//
//  AuctionFilterButton.swift
//  AuctionHome
//
//  Created by 송하민 on 12/28/25.
//

import SwiftUI

import UIComponent

struct AuctionFilterButton: View {
  let type: AuctionFilterType
  let isActive: Bool
  let title: String
  let action: () -> Void
  
  var body: some View {
    Button(action: action) {
      HStack(spacing: 4) {
        if let image = type.leftImage {
          image
            .resizable()
            .frame(width: 16, height: 16)
        }
        
        Text(title)
          .fonts(.bodyMiniMedium)
          .foregroundStyle(isActive ? Asset.Colors.neutralWhite.color : Asset.Colors.neutral.color)
        
        if type.isExpandable {
          Asset.Images.arrowDownNoShaft.image
            .renderingMode(.template)
            .resizable()
            .foregroundStyle(isActive ? Asset.Colors.neutralWhite.color : Asset.Colors.neutral.color)
            .frame(width: 16, height: 16)
        }
      }
      .padding(.vertical, 8)
      .padding(.horizontal, 12)
      .overlay {
        Capsule()
          .stroke(style: .init(lineWidth: 1))
          .foregroundStyle(isActive ? .clear : Asset.Colors.gray150.color)
      }
      .background(isActive ? Asset.Colors.neutral.color : .clear)
      .clipShape(Capsule())
    }
  }
}
