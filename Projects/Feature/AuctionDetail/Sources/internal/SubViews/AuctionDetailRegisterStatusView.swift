//
//  AuctionDetailRegisterStatus.swift
//  AuctionDetail
//
//  Created by 송하민 on 12/14/25.
//

import SwiftUI

import UIComponent
import Domain

struct AuctionDetailRegisterStatusView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: .zero) {
      Text("등기부 현황")
        .fonts(.titleMediumBold)
        .foregroundStyle(Asset.Colors.neutral.color)
        .padding(.bottom, 20)
      
      VStack(spacing: 24) {
        // 매각효력
        HStack(spacing: .zero) {
          Text("매각효력")
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutralSubtler.color)
          Spacer()
          Text("매각효력 있음")
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutral.color)
        }
          
        // 지상권
        HStack(spacing: .zero) {
          Text("지상권")
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutralSubtler.color)
          Spacer()
          Text("해당사항 없음")
            .fonts(.bodyMediumMedium)
            .foregroundStyle(Asset.Colors.neutral.color)
        }
      }
    }
    .padding(.vertical, 24)
    .padding(.horizontal, 20)
  }
}
