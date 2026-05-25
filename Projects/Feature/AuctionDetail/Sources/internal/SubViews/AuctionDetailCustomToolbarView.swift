//
//  AuctionDetailCustomToolbarView.swift
//  Auction
//
//  Created by 송하민 on 11/2/25.
//

import SwiftUI

import Domain
import UIComponent

struct AuctionDetailCustomToolbarView: View {
  @Environment(\.dismiss) var dismiss
  @State private var isShareSheetPresented: Bool = false
  @State private var pendingShareAction: AuctionShareAction?
  let auctionDetailInfo: AuctionDetail

  private var shareText: String {
    [
      auctionDetailInfo.salesAddress,
      "사건번호: \(auctionDetailInfo.salesNumber)"
    ]
    .joined(separator: "\n")
  }

  var body: some View {
    HStack {
      Button {
        dismiss()
      } label: {
        Asset.Images.arrowLeft.image
          .resizable()
          .frame(width: 28, height: 28)
      }

      Text(auctionDetailInfo.salesAddress)
        .fonts(.bodyLargeBold)
        .lineLimit(1)
        .truncationMode(.tail)

      Spacer()

      Button {
        isShareSheetPresented = true
      } label: {
        Asset.Images.share.image
          .resizable()
          .frame(width: 28, height: 28)
      }
    }
    .frame(height: 60)
    .padding(.horizontal, 16)
    .sheet(isPresented: $isShareSheetPresented, onDismiss: handlePendingShareAction) {
      AuctionShareBottomSheet(
        auctionDetailInfo: auctionDetailInfo,
        onSelect: { action in
          pendingShareAction = action
        }
      )
      .dynamicSheet()
    }
  }

  private func handlePendingShareAction() {
    guard let action = pendingShareAction else { return }
    pendingShareAction = nil
    switch action {
    case .link:
      AuctionLinkSharePresenter.present(items: [shareText])
    case .kakao:
      AuctionKakaoShareSender.send(auction: auctionDetailInfo)
    }
  }
}
