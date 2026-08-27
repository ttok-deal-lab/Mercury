//
//  NetworkDisconnectPresenter.swift
//  UIComponent
//
//  Created by 최수훈 on 8/27/26.
//

import Foundation

import AppFoundation

/// 네트워크 끊김 안내 바텀시트를 명령형으로 다시 띄우기 위한 트리거.
///
/// `networkDisconnectSheet()` 는 연결 상태가 바뀌는 순간에만 시트를 띄운다.
/// 사용자가 오프라인 상태에서 시트를 내려버리면 다음 상태 변화까지 안내가 없으므로,
/// 버튼 탭처럼 "지금 안내가 필요한" 시점에 이 트리거로 재표시를 요청한다.
///
/// 시트 소유권은 `networkDisconnectSheet()` 한 곳에만 두고 여기서는 요청만 발행한다.
/// 프레젠테이션 컨텍스트마다 `.sheet` 를 따로 만들면 서로 충돌한다.
@Observable
public final class NetworkDisconnectPresenter {
  public static let shared = NetworkDisconnectPresenter()

  /// 재표시 요청 카운터. 모디파이어가 변화를 관찰한다.
  public private(set) var requestID: Int = 0

  private init() { }

  /// 연결돼 있으면 `true`, 끊겨 있으면 안내 시트를 띄우고 `false` 를 반환한다.
  ///
  /// ```swift
  /// guard NetworkDisconnectPresenter.shared.ensureConnected() else { return }
  /// ```
  @discardableResult
  @MainActor
  public func ensureConnected() -> Bool {
    guard !NetworkMonitor.shared.isConnected else { return true }
    self.requestID += 1
    return false
  }
}
