//
//  SampleRoute.swift
//  Coordinator
//
//  Created by 송하민 on 12/29/24.
//

import SwiftUI

import Router

enum SampleRoute: String, Hashable, Identifiable, CaseIterable {
  var id: String {
    return self.rawValue
  }
  
  case a
  case b
  case c
  case d
  case e
  case f
  case g
}



