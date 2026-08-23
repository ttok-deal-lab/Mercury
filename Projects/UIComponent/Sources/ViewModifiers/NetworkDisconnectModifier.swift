//
//  NetworkDisconnectModifier.swift
//  UIComponent
//
//  Created by 최수훈 on 8/23/26.
//

import SwiftUI

import AppFoundation

/// 네트워크 연결이 끊기면 바텀시트로 안내한다.
///
/// `.sheet` 은 자신보다 위 계층에 올라온 프레젠테이션(`fullScreenCover`, 다른 `sheet`)을
/// 넘어서지 못한다. 그래서 앱 전체에 한 번 붙이는 방식이 불가능하고,
/// 화면을 통째로 덮는 프레젠테이션 컨텍스트마다(루트, fullScreenCover 내부) 개별로 붙인다.
struct NetworkDisconnectModifier: ViewModifier {
  private let networkMonitor = NetworkMonitor.shared
  private let isEnabled: Bool
  @State private var isShowNetworkDisconnect: Bool = false

  init(isEnabled: Bool) {
    self.isEnabled = isEnabled
  }

  func body(content: Content) -> some View {
    content
      // onChange 는 최초 값에 발동하지 않는다. 오프라인으로 앱을 켠 경우
      // NWPathMonitor 의 첫 콜백이 구독보다 앞설 수 있어 진입 시 한 번 확인한다.
      .onAppear {
        syncPresentation()
      }
      .onChange(of: networkMonitor.isConnected) { _, _ in
        syncPresentation()
      }
      .onChange(of: isEnabled) { _, _ in
        syncPresentation()
      }
      .sheet(isPresented: $isShowNetworkDisconnect) {
        NetworkDisconnectView()
      }
  }

  private func syncPresentation() {
    self.isShowNetworkDisconnect = isEnabled && !networkMonitor.isConnected
  }
}

private struct NetworkDisconnectView: View {
  var body: some View {
    VStack { // TODO: 디자인 필요
      Text("인터넷 연결이 되지 않아요")
        .fonts(.titleMediumBold)
        .padding(.vertical, 18)
      Text("인터넷 상태를 확인해주세요")
        .fonts(.bodyLargeMedium)
      Text("인터넷 연결이 되면 바로 사용할 수 있어요")
        .fonts(.bodyLargeMedium)
        .padding(.vertical, 18)
    }
    .dynamicSheet()
  }
}

public extension View {
  /// 네트워크 연결 끊김 안내 바텀시트를 붙인다.
  /// - Parameter isEnabled: 위 계층이 프레젠테이션을 점유한 동안(예: `fullScreenCover` 표시 중)
  ///   `false` 를 넘겨 중복 present 를 막는다.
  func networkDisconnectSheet(isEnabled: Bool = true) -> some View {
    self.modifier(NetworkDisconnectModifier(isEnabled: isEnabled))
  }
}
