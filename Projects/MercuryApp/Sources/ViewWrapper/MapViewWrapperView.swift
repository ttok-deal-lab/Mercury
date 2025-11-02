//
//  MapViewWrapperView.swift
//  MercuryApp
//
//  Created by 송하민 on 11/2/25.
//

import SwiftUI
import Combine

import Router
import Map
import Domain
import Infrastructure

public struct MapViewWrapperView: View, MapViewable {
  
  private let hostView: MapContentView
  
  public init() {
    self.hostView = MapContentView()
  }
  
  public var body: some View {
    hostView
  }
  
  
}
