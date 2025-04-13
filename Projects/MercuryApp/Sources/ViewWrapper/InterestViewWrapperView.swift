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
  
  let hostView: InterestView
  
  public init(navigationSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    self.hostView = InterestView(navigationSubject: navigationSubject)
  }
  
  public var body: some View {
    hostView
  }
}
