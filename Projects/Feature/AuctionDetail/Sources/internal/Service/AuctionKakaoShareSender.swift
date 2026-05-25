//
//  AuctionKakaoShareSender.swift
//  AuctionDetail
//
//  Created by 송하민 on 5/25/26.
//

import Foundation
import UIKit

import KakaoSDKShare
import KakaoSDKTemplate

import Domain

/// 경매 상세 공유 URL 생성기.
/// 후속 PR에서 실제 딥링크 스킴/유니버설 링크로 교체될 예정.
enum AuctionShareLink {
  static func url(for auctionID: Int) -> URL {
    // swiftlint:disable:next force_unwrapping
    URL(string: "https://mercury.example.com/auction/\(auctionID)")!
  }
}

/// 카카오톡 FeedTemplate 전송 헬퍼.
/// - 카카오톡 설치: 카카오톡 앱 호출 → 메시지 전송 화면
/// - 미설치: Safari 폴백 (`makeDefaultUrl`)
@MainActor
enum AuctionKakaoShareSender {
  static func send(auction: AuctionDetail) {
    let shareURL = AuctionShareLink.url(for: auction.id)
    let imageURL = auction.salesPictures.first?.url
      ?? URL(string: "https://placehold.co/600x400")!

    let link = Link(webUrl: shareURL, mobileWebUrl: shareURL)
    let content = Content(
      title: auction.salesAddress,
      imageUrl: imageURL,
      description: "사건번호: \(auction.salesNumber)",
      link: link
    )
    let buttons = [Button(title: "자세히 보기", link: link)]
    let template = FeedTemplate(content: content, buttons: buttons)

    if ShareApi.isKakaoTalkSharingAvailable() {
      ShareApi.shared.shareDefault(templatable: template) { result, error in
        guard let result, error == nil else { return }
        UIApplication.shared.open(result.url, options: [:], completionHandler: nil)
      }
    } else {
      guard let url = ShareApi.shared.makeDefaultUrl(templatable: template) else { return }
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
  }
}
