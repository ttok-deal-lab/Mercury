//
//  MapUsecase.swift
//  DomainInterface
//
//  Created by 송하민 on 8/10/24.
//

import Foundation
import AppFoundation

public protocol MapUsecase {
  func addMarkers() async -> Result<Void, MercuryError>
  func markerLocation() async -> Result<GeoLocation, MercuryError>
}
