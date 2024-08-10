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
  
  @StateObject private var locationManager = LocationManager()
//  @StateObject private var locationDelegateAdopter = LocationManagerDelegateAdopter()
  
  @State var draw: Bool = false
  
  var body: some View {
    KakaoMapView(
      draw: $store.draw,
      userLocation: Binding(
        get: { store.userLocation },
        set: { newValue in
          store.send(.setUserLocation(newValue.map { CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude) }!))
        }
      )
    )
    .onAppear(perform: {
      self.draw = true
    })
    .onDisappear(perform: {
      self.draw = false
    })
    .task {
      self.store.send(.checkUserAuthorization)
    }
    .alert(isPresented: $store.isShowAlert) {
      Alert(title: Text("알림"), message: Text("설정에서 위치정보를 허용해주세요."), dismissButton: .default(Text("확인")))
    }
  }
  
  
  class LocationManagerDelegateAdopter: LocationManagerDelegate, ObservableObject {
   
    @Published var userLocation: CLLocationCoordinate2D?
    
    func currentUserLocation(location: CLLocationCoordinate2D?) {
      self.userLocation = location
    }
  }
  
}


