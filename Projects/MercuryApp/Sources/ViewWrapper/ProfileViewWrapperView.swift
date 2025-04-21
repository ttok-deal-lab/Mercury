//
//  MyPageViewWrapperView.swift
//  MercuryApp
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import Router
import MyPage

public struct MyPageViewWrapperView: View, MyPageViewable {
  
  let hostView: MyPageView
  
  public init(navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    self.hostView = MyPageView(navigationStream: navigationStream)
  }
  
  public var body: some View {
    hostView
  }
}
