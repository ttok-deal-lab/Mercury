//
//  MapStore.swift
//  Map
//
//  Created by 송하민 on 10/4/24.
//

import SwiftUI
import AppFoundation
import Foundation
import CoreLocation

public class MapStore: ObservableObject {
  
  // MARK: - published property
  
  @Published public var error: MercuryError?
  @Published public var isMapDraw: Bool = true
  @Published public var isShowDeniedLocationAlert: Bool?
  @Published public var userLocation: CLLocationCoordinate2D?
  @Published public var cameraCenterLocation: CLLocationCoordinate2D?
  
  // MARK: - private property
  
  private var userLocationClient: UserLocationClient
  
  // MARK: - life cycle
  
  init(userLocationClient: UserLocationClient) {
    self.userLocationClient = userLocationClient
  }
  
  // MARK: - private method
  
  // MARK: - public method

  func setError(_ error: MercuryError) {
    self.error = error
  }
  
  func setDrawMap(_ isDraw: Bool) {
    self.isMapDraw = isDraw
  }
  
  func checkUserAuthorization() {
    if let status = self.userLocationClient.userAuthorization() {
      switch status {
      case .notDetermined, .restricted:
        requestLocationAuthentication()
      case .denied:
        setIsShowDeniedLocationAlert(true)
      case .authorizedAlways, .authorizedWhenInUse:
        updateUserLocation()
      @unknown default:
        setError(.init(from: .ownModule(.map), .unknownLocationAuthenticationStatus))
      }
    }
  }
  
  func requestLocationAuthentication() {
    Task {
      if let status = await self.userLocationClient.requestUserAuthorization() {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
          updateUserLocation()
        case .denied:
          setIsShowDeniedLocationAlert(true)
        default:
          break
        }
      }
    }
  }
  
  func setIsShowDeniedLocationAlert(_ isShow: Bool) {
    self.isShowDeniedLocationAlert = isShow
  }
  
  func updateUserLocation() {
    Task {
      if let location = self.userLocationClient.userCurrentLocation() {
        setUserLocation(location)
      } else {
        setError(.init(from: .ownModule(.map), .failToGetUserLocationCoordinate))
      }
    }
  }
  
  func setUserLocation(_ location: CLLocationCoordinate2D) {
    self.userLocation = location
  }
  
  func setCameraCenterLocation(_ location: CLLocationCoordinate2D?) {
    self.cameraCenterLocation = location
  }
  
}
