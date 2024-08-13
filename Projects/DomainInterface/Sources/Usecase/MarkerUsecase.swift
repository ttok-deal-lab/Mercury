//
//  MarkerUsecase.swift
//  DomainInterface
//
//  Created by 송하민 on 8/13/24.
//

import CoreLocation
import AppFoundation

public typealias MarkerCoordinate = CLLocationCoordinate2D

public protocol MarkerUsecase {
  
  func loadMarkers() async -> Result<[MarkerCoordinate], MercuryError>
  
}
