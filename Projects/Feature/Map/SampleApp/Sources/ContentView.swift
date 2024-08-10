//
//  ContentView.swift
//  MapSampleApp
//
//  Created by 송하민 on 8/7/24.
//

import Map
import SwiftUI
import CoreLocation

struct ContentView: View {
  
  // MARK: - private property
  
  // MARK: - internal property
  
  @StateObject private var locationManager = LocationManager()
  @StateObject private var locationDelegateAdopter = LocationManagerDelegateAdopter()
  @State var draw: Bool = false
  
  var body: some View {
    KakaoMapView(draw: $draw, userLocation: $locationDelegateAdopter.userLocation)
      .onAppear(perform: {
        self.draw = true
      })
      .onDisappear(perform: {
        self.draw = false
      })
      .task {
        self.locationManager.delegate = self.locationDelegateAdopter
        self.locationManager.checkLocationAutorizationStatus()
      }
      .alert(isPresented: $locationManager.showAlert) {
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


