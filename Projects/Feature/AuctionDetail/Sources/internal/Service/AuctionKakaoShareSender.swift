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
/// 카카오 개발자 콘솔에 등록된 도메인이어야 미설치 사용자 웹 폴백이 정상 동작한다.
/// (미등록 도메인이면 카카오가 등록된 도메인(localhost 등)으로 폴백시킴)
enum AuctionShareLink {
  static func url(for auctionID: Int) -> URL {
    // swiftlint:disable:next force_unwrapping
    URL(string: "https://ttok-front-dev.estateslug.com/sales/\(auctionID)")!
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

    // iosExecutionParams: 카카오톡 설치 시 estateSlug 딥링크로 앱의 상세 화면을 연다.
    // (카카오 콘솔 iOS 플랫폼에 estateSlug 커스텀 스킴 등록 필요. 미설치 시 webUrl 로 폴백)
    let link = Link(
      webUrl: shareURL,
      mobileWebUrl: shareURL,
      androidExecutionParams: ["path": "sales/\(auction.id)"],
      iosExecutionParams: ["path": "sales/\(auction.id)"]
    )
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
