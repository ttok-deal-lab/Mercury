//
//  MyPageView.swift
//  Profile
//
//  Created by 송하민 on 8/3/24.
//

import SwiftUI
import Combine

import Router
import UIComponent

public struct MyPageView: View {
  @StateObject private var viewModel = MyPageModelData()
  private var navigationSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
  public init(navigationSubject: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    self.navigationSubject = navigationSubject
  }
  
  public var body: some View {
    Text("Profile")
      .foregroundStyle(.black)
  }
  
}
