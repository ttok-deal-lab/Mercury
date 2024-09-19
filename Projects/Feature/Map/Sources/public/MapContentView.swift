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
    WithPerceptionTracking {
      KakaoMapView(
        draw: $store.isMapDraw,
        userLocation: store.userLocation,
        cameraCenterLocation: Binding(
          get: { store.cameraCenterLocation },
          set: { newValue in
            if newValue != store.cameraCenterLocation {
              store.send(.setCameraCenterLocation(newValue))
            }
          }
        ),
        auctionItems: store.auctionItems
      )
      .onAppear {
        if !store.isMapDraw {
          store.send(.setDrawMap(true))
        }
      }
      .onDisappear {
        if store.isMapDraw {
          store.send(.setDrawMap(false))
        }
      }
      .task {
        await store.send(.checkUserAuthorization).finish()
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
}


