//
//  CrewLeaderLinkListView.swift
//  Report
//
//  Created by 최수훈 on 10/9/26.
//

import SwiftUI

import UIComponent

struct CrewLeaderLinkListView: View {
  
  @Binding var links: [CrewLeaderLinkInput]
  let onAdd: () -> Void
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      ForEach($links) { $link in
        CrewLeaderTextFieldView(
          text: $link.url,
          placeholder: L10n.reportLeaderProfileLinkPlaceholder,
          showsClearButton: true
        )
      }
      
      Button(action: onAdd) {
        Text(L10n.reportLeaderProfileLinkAdd)
          .fonts(.bodyMicroMedium)
          .foregroundStyle(Asset.Colors.neutral.color)
          .padding(.horizontal, 12)
          .padding(.vertical, 8)
          .background(Asset.Colors.neutralWeak.color)
          .clipShape(RoundedRectangle(cornerRadius: 8))
      }
    }
  }
}
