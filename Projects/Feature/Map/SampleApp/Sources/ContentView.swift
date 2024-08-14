//
//  ContentView.swift
//  MapSampleApp
//
//  Created by 송하민 on 8/7/24.
//

import Map
import SwiftUI
import CoreLocation
import ComposableArchitecture

struct ContentView: View {
  
  // MARK: - private property
  
  // MARK: - internal property
  
  @Perception.Bindable var store: StoreOf<MapReducer>
  
  var body: some View {
    KakaoMapView(
      draw: $store.isMapDraw,
      userLocation: store.userLocation,
      cameraCenterLocation: Binding(
        get: { store.cameraCenterLocation },
        set: { store.send(.setCameraCenterLocation($0)) })
    )
    .onAppear(perform: {
      self.store.send(.setDrawMap(true))
    })
    .onDisappear(perform: {
      self.store.send(.setDrawMap(false))
    })
    .task {
      self.store.send(.checkUserAuthorization)
    }
    .alert(isPresented: $store.isShowDeniedLocationAlert) {
      Alert(
        title: Text("알림"),
        message: Text("설정에서 위치정보를 허용해주세요."),
        dismissButton: .default(Text("확인"))
      )
    }
  }
}


