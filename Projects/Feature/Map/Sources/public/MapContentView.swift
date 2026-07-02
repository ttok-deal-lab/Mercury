//
//  ContentView.swift
//  MapSampleApp
//
//  Created by 송하민 on 8/7/24.
//


import SwiftUI
import CoreLocation

import AppFoundation
import Router
import UIComponent

public struct MapContentView: View {
  @State private var store: MapStore
  
  public init(targetLongitude: Double, targetLatitude: Double) {
    self.store = MapStore(
      userLocationClient: UserLocationClientLive(),
      targetCoordinate: CLLocationCoordinate2D(
        latitude: targetLatitude,
        longitude: targetLongitude
      )
    )
  }
  
  public var body: some View {
    KakaoMapView(
      draw: $store.isMapDraw,
      cameraCenterLocation: Binding(get: {
        store.cameraCenterLocation
      }, set: { newValue in
        if newValue != store.cameraCenterLocation {
          store.setCameraCenterLocation(newValue)
        }
      })
    )
    .onAppear {
      if !store.isMapDraw {
        store.setDrawMap(true)
      }
    }
    .onDisappear {
      if store.isMapDraw {
        store.setDrawMap(false)
      }
    }
  }
}

