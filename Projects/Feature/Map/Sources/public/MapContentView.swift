//
//  ContentView.swift
//  MapSampleApp
//
//  Created by 송하민 on 8/7/24.
//


import SwiftUI
import CoreLocation

import AppFoundation
import Coordinator
import UIComponent

public struct MapContentView: View {
  
  // MARK: - private property
  
  @StateObject private var store = MapStore(userLocationClient: UserLocationClientLive())
  
  @ObservedObject private var coordinator: CoordinatorManager
  
  
  // MARK: - life cycle
  
  public init(coordinator: CoordinatorManager) {
    self.coordinator = coordinator
  }
  
  public var body: some View {
    KakaoMapView(
      draw: $store.isMapDraw,
      userLocation: store.userLocation,
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

