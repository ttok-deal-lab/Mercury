//
//  MapMarker.swift
//  AppFoundation
//
//  Created by 송하민 on 8/10/24.
//

import Foundation

public struct GeoLocation {
  var latitude: Double
  var longitude: Double
  var address: Address?
}

struct Address {
  let street: String?
  let city: String?
  let state: String?
  let country: String?
  let postalCode: String?
}
