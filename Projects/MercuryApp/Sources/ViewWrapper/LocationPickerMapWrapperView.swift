//
//  LocationPickerMapWrapperView.swift
//  MercuryApp
//
//  Created by 최수훈 on 10/10/26.
//

import SwiftUI

import Router
import Map

public struct LocationPickerMapWrapperView: View, LocationPickerMapViewable {
  
  private let hostView: LocationPickerMapView
  
  public init(
    initialLatitude: Double,
    initialLongitude: Double,
    moveRequest: Binding<LocationPickerMoveRequest?>,
    onCenterChanged: @escaping (Double, Double) -> Void,
    onMoveStarted: @escaping () -> Void
  ) {
    self.hostView = LocationPickerMapView(
      initialLatitude: initialLatitude,
      initialLongitude: initialLongitude,
      moveRequest: moveRequest,
      onCenterChanged: onCenterChanged,
      onMoveStarted: onMoveStarted
    )
  }
  
  public var body: some View {
    hostView
  }
}
