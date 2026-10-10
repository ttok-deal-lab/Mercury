//
//  NavigationEvent.swift
//  Router
//
//  Created by 송하민 on 4/1/25.
//


import SwiftUI

public enum NavigationEvent<Route: Hashable> {
  case push(Route)
  case pop
  case popTo(Route)
  case popToRoot
  /// 스택을 비우고 route 하나만 남긴다. popToRoot 와 push 를 따로 보내면 NavigationStack 이 전환 중 두 번째 변경을 무시할 수 있어 한 번에 바꾼다.
  case replaceStack(Route)
  case presentFullScreen(Route)
  case dismissFullScreen
  
}
