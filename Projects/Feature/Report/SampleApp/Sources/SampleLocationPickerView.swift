import SwiftUI

import Router

/// 샘플 앱용 지도 대체 뷰. Map 모듈(Feature) 을 끌어오지 않고, 탭하면 좌표가 바뀐 것처럼 알린다.
struct SampleLocationPickerView: View, LocationPickerMapViewable {
  let initialLatitude: Double
  let initialLongitude: Double
  @Binding var moveRequest: LocationPickerMoveRequest?
  let onCenterChanged: (Double, Double) -> Void
  let onMoveStarted: () -> Void
  
  init(
    initialLatitude: Double,
    initialLongitude: Double,
    moveRequest: Binding<LocationPickerMoveRequest?>,
    onCenterChanged: @escaping (Double, Double) -> Void,
    onMoveStarted: @escaping () -> Void
  ) {
    self.initialLatitude = initialLatitude
    self.initialLongitude = initialLongitude
    self._moveRequest = moveRequest
    self.onCenterChanged = onCenterChanged
    self.onMoveStarted = onMoveStarted
  }
  
  var body: some View {
    Color.gray.opacity(0.2)
      .overlay(Text("SAMPLE MAP").foregroundStyle(.gray))
      .onAppear { onCenterChanged(initialLatitude, initialLongitude) }
      .onTapGesture { onCenterChanged(initialLatitude + 0.001, initialLongitude) }
  }
}
