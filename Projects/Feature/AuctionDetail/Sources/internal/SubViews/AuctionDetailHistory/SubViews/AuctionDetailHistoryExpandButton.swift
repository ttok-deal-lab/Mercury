//
//  ExpandButton.swift
//  AuctionDetail
//
//  Created by 송하민 on 12/13/25.
//

import SwiftUI

struct AuctionDetailHistoryExpandButton: View {
  let isExpanded: Bool
  let isEnabled: Bool
  let onTap: () -> Void

  var body: some View {
    ZStack {
      Button(action: onTap) {
        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
          .font(.system(size: 14, weight: .semibold))
          .foregroundStyle(.secondary)
          .frame(maxWidth: .infinity)
          .padding(.vertical, 12)
          .contentShape(Rectangle())
      }
      .buttonStyle(.plain)
      .disabled(!isEnabled)
    }
  }
}
