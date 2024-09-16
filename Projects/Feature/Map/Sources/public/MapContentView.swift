//
//  ContentView.swift
//  MapSampleApp
//
//  Created by 송하민 on 8/7/24.
//

import SwiftUI
import CoreLocation
import ComposableArchitecture

public struct MapContentView: View {
  
  // MARK: - private property
  
  @Perception.Bindable private var store: StoreOf<MapReducer>
  

  // MARK: - internal property
  
  // MARK: - life cycle
  
  public init(store: StoreOf<MapReducer>) {
    self.store = store
  }
  
  
  public var body: some View {
    KakaoMapView(
      draw: $store.isMapDraw,
      userLocation: store.userLocation,
      cameraCenterLocation: Binding(
        get: { store.cameraCenterLocation },
        set: { store.send(.setCameraCenterLocation($0)) }
      ),
      auctionItems: store.auctionItems
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


