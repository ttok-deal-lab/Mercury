//
//  LocationManagerDelegate.swift
//  MapSampleApp
//
//  Created by 송하민 on 8/10/24.
//

import UIKit
import Foundation
import CoreLocation

public class LocationManagerDelegate: NSObject, CLLocationManagerDelegate, ObservableObject {
  
  // MARK: - private property
  
  private var locationManager: CLLocationManager = CLLocationManager()
  @Published public var showAlert: Bool = false
  
  
  // MARK: - life cycle
  
  public override init() {
    super.init()
    self.locationManager.delegate = self
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - private method
  
  // MARK: - internal method
  
  public func checkLocationAutorizationStatus() {
    let status = self.locationManager.authorizationStatus
    switch status {
    case .notDetermined, .restricted:
      self.locationManager.requestWhenInUseAuthorization()
    case .denied:
      showAlert = true
    case .authorizedAlways, .authorizedWhenInUse:
      break
    default:
      break
    }
  }
  
  
}
