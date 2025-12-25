//
//  MyPageViewWrapperView.swift
//  MercuryApp
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import Domain
import Router
import MyPage
import Infrastructure

public struct MyPageViewWrapperView: View, MyPageViewable {
  
  let hostView: MyPageView
  
  public init() {
    self.hostView = MyPageView(userProfileUsecase: MyPageUsecase(repository: MyPageRepository()))
  }
  
  public var body: some View {
    hostView
  }
}
