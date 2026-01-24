//
//  InterestViewWrapperView.swift
//  MercuryApp
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import Router
import Interest

public struct InterestViewWrapperView: View, InterestViewable {
  
  let hostView: AuctionInterestView
  
  public init() {
    self.hostView = AuctionInterestView()
  }
  
  public var body: some View {
    hostView
  }
}
