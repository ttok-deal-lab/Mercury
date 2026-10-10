//
//  LocationPickerCameraTarget.swift
//  Map
//
//  Created by 최수훈 on 10/10/26.
//

import Foundation
import CoreLocation

struct LocationPickerCameraTarget: Equatable {
  let id: UUID
  let coordinate: CLLocationCoordinate2D
  
  static func == (lhs: Self, rhs: Self) -> Bool { lhs.id == rhs.id }
}
