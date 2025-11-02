//
//  MapViewable.swift
//  Router
//
//  Created by 송하민 on 11/2/25.
//

import SwiftUI

public protocol MapViewable where Self: View {
  init(targetLongitude: Double, targetLatitude: Double)
}
