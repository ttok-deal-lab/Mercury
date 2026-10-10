//
//  LocationPickerMapViewable.swift
//  Router
//
//  Created by 최수훈 on 10/10/26.
//

import SwiftUI

/// 지도를 움직여 위치를 고르는 지도 뷰. 지도가 멈출 때마다 화면 중앙 좌표를 알려준다.
/// 중앙 핀·버튼 같은 UI 는 사용하는 화면이 위에 얹는다.
public protocol LocationPickerMapViewable where Self: View {
  init(
    initialLatitude: Double,
    initialLongitude: Double,
    moveRequest: Binding<LocationPickerMoveRequest?>,
    onCenterChanged: @escaping (_ latitude: Double, _ longitude: Double) -> Void,
    onMoveStarted: @escaping () -> Void
  )
}
