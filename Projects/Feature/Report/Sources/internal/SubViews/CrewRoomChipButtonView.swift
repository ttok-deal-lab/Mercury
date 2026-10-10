//
//  CrewRoomChipButtonView.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import SwiftUI

import UIComponent

struct CrewRoomChipButtonView: View {
  
  let title: String
  let onTap: () -> Void
  
  var body: some View {
    Button(action: onTap) {
      Text(title)
        .fonts(.bodySmallMedium)
        .foregroundStyle(Asset.Colors.neutral.color)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Asset.Colors.neutralWeak.color)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
  }
}
