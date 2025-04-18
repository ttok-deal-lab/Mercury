//
//  NavigationEvent.swift
//  Router
//
//  Created by 송하민 on 4/1/25.
//


import SwiftUI

public enum NavigationEvent<Route: Hashable> {
  case push(Route)
  case pop
  case popTo(Route)
  case popToRoot
  case presentFullScreen(Route)
  case dismissFullScreen
  
}
