//
//  ProfileViewWrapperView.swift
//  MercuryApp
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import Router
import Profile

public struct ProfileViewWrapperView: View, ProfileViewable {
  
  let hostView: ProfileView
  
  public init(navigationSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    self.hostView = ProfileView()
  }
  
  public var body: some View {
    hostView
  }
}
