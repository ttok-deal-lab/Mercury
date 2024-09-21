//
//  CLLocationCoordinate2D+Extension.swift
//  AppFoundation
//
//  Created by 송하민 on 9/21/24.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D: @retroactive Equatable {
  
  public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
  }
  
}
