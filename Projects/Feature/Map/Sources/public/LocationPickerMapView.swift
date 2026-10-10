//
//  LocationPickerMapView.swift
//  Map
//
//  Created by 최수훈 on 10/10/26.
//

import SwiftUI
import CoreLocation

import Router

/// 위치 선택 지도 (Router `LocationPickerMapViewable` 구현).
public struct LocationPickerMapView: View {
  private let initialCoordinate: CLLocationCoordinate2D
  @Binding private var moveRequest: LocationPickerMoveRequest?
  private let onCenterChanged: (Double, Double) -> Void
  private let onMoveStarted: () -> Void
  
  public init(
    initialLatitude: Double,
    initialLongitude: Double,
    moveRequest: Binding<LocationPickerMoveRequest?>,
    onCenterChanged: @escaping (Double, Double) -> Void,
    onMoveStarted: @escaping () -> Void
  ) {
    self.initialCoordinate = CLLocationCoordinate2D(latitude: initialLatitude, longitude: initialLongitude)
    self._moveRequest = moveRequest
    self.onCenterChanged = onCenterChanged
    self.onMoveStarted = onMoveStarted
  }
  
  public var body: some View {
    KakaoLocationPickerMapView(
      initialCoordinate: initialCoordinate,
      moveRequest: moveRequest.map {
        LocationPickerCameraTarget(id: $0.id, coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude))
      },
      onCenterChanged: { onCenterChanged($0.latitude, $0.longitude) },
      onMoveStarted: onMoveStarted
    )
  }
}
