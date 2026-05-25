//
//  AuctionShareBottomSheet.swift
//  AuctionDetail
//
//  Created by 송하민 on 5/25/26.
//

import SwiftUI

import Domain
import UIComponent

/// 경매 상세 공유 옵션 선택지.
enum AuctionShareAction {
  case link
  case kakao
}

/// 경매 상세 공유 옵션을 보여주는 바텀시트.
/// 실제 share 동작은 시트가 닫힌 뒤 호출자가 처리한다 (`onSelect`).
/// 이렇게 해야 시스템 액티비티 시트가 본 시트 위에 stack되지 않는다.
struct AuctionShareBottomSheet: View {
  let auctionDetailInfo: AuctionDetail
  let onSelect: (AuctionShareAction) -> Void
  @Environment(\.dismiss) private var dismiss

  var body: some View {
    VStack(spacing: 0) {
      Text("공유하기")
        .fonts(.titleMediumBold)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.bottom, 16)

      VStack(spacing: 0) {
        Button {
          select(.link)
        } label: {
          AuctionShareRowLabel(
            iconContent: .system(name: "link", tint: Asset.Colors.primary.color),
            title: "링크로 직접 공유하기"
          )
        }
        .buttonStyle(.plain)

        Divider()
          .padding(.leading, 56)

        Button {
          select(.kakao)
        } label: {
          AuctionShareRowLabel(
            iconContent: .asset(image: Asset.Images.kakao.image),
            title: "카카오톡으로 공유하기"
          )
        }
        .buttonStyle(.plain)
      }
    }
  }

  private func select(_ action: AuctionShareAction) {
    onSelect(action)
    dismiss()
  }
}

// MARK: - Row Label

private struct AuctionShareRowLabel: View {
  enum IconContent {
    case asset(image: Image)
    case system(name: String, tint: Color)
  }

  let iconContent: IconContent
  let title: String

  var body: some View {
    HStack(spacing: 12) {
      iconView
        .frame(width: 24, height: 24)
      Text(title)
        .fonts(.bodyLargeBold)
        .foregroundStyle(Asset.Colors.neutral.color)
      Spacer()
      Image(systemName: "chevron.right")
        .foregroundStyle(Asset.Colors.neutralMuted.color)
    }
    .padding(.horizontal, 20)
    .frame(height: 56)
    .contentShape(Rectangle())
  }

  @ViewBuilder
  private var iconView: some View {
    switch iconContent {
    case .asset(let image):
      image
        .resizable()
        .aspectRatio(contentMode: .fit)
    case .system(let name, let tint):
      Image(systemName: name)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .foregroundStyle(tint)
    }
  }
}

// MARK: - System Activity Sheet bridge

/// 현재 keyWindow 의 최상단 presented controller 위에 `UIActivityViewController` 를 띄운다.
/// `onDismiss` 콜백에서 호출하여 본 시트가 닫힌 뒤 시스템 시트만 노출되도록 한다.
@MainActor
enum AuctionLinkSharePresenter {
  static func present(items: [Any]) {
    guard
      let scene = UIApplication.shared.connectedScenes
        .compactMap({ $0 as? UIWindowScene })
        .first(where: { $0.activationState == .foregroundActive }),
      let root = scene.windows.first(where: \.isKeyWindow)?.rootViewController
    else { return }

    let activityController = UIActivityViewController(
      activityItems: items,
      applicationActivities: nil
    )

    var presenter: UIViewController = root
    while let next = presenter.presentedViewController, !next.isBeingDismissed {
      presenter = next
    }
    presenter.present(activityController, animated: true)
  }
}
