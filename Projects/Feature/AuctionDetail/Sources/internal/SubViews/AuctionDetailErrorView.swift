//
//  AuctionDetailErrorView.swift
//  AuctionDetail
//
//  Created by 최수훈 on 8/9/26.
//

import SwiftUI

import UIComponent

/// 경매 상세 로딩 실패 화면.
/// 상세 응답을 못 받은 상태라 툴바에 주소·공유를 띄울 수 없어 뒤로가기만 노출한다.
struct AuctionDetailErrorView: View {
  @Environment(\.dismiss) private var dismiss
  let isAuctionUnavailable: Bool
  let onRetry: () -> Void

  var body: some View {
    VStack(spacing: .zero) {
      HStack {
        Button {
          dismiss()
        } label: {
          Asset.Images.arrowLeft.image
            .resizable()
            .frame(width: 28, height: 28)
        }

        Spacer()
      }
      .frame(height: 60)
      .padding(.horizontal, 16)

      Spacer()

      VStack(spacing: 16) {
        Image(systemName: "ellipsis")
          .font(.system(size: 22, weight: .semibold))
          .foregroundStyle(Asset.Colors.neutralMuted.color)
          .frame(width: 64, height: 64)
          .background(Asset.Colors.neutralWeak.color)
          .clipShape(Circle())

        Text(isAuctionUnavailable ? "매물을 찾을 수 없어요." : "일시적인 오류가 발생했어요.")
          .fonts(.bodyMicroMedium)
          .foregroundStyle(Asset.Colors.neutralSubtler.color)

        if isAuctionUnavailable {
          Button("홈으로") {
            dismiss()
          }
          .fonts(.bodyMicroMedium)
          .foregroundStyle(Asset.Colors.neutralWhite.color)
          .padding(.horizontal, 20)
          .padding(.vertical, 10)
          .background(Asset.Colors.primary.color)
          .clipShape(RoundedRectangle(cornerRadius: 8))
        } else {
          Button {
            onRetry()
          } label: {
            Text("재시도")
              .fonts(.bodyMicroMedium)
              .foregroundStyle(Asset.Colors.neutralWhite.color)
              .padding(.horizontal, 20)
              .padding(.vertical, 10)
              .background(Asset.Colors.primary.color)
              .clipShape(RoundedRectangle(cornerRadius: 8))
          }
        }
      }

      Spacer()
    }
  }
}
