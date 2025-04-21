//
//  ReportView.swift
//  Report
//
//  Created by 송하민 on 4/13/25.
//

import Foundation
import SwiftUI
import Combine

import AppFoundation
import UIComponent
import Router

public struct ReportView: View {
  @StateObject private var modelData = ReportModelData()
  private let navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>
  
  public init(navigationStream: PassthroughSubject<NavigationEvent<FeatureRoute>, Never>) {
    self.navigationStream = navigationStream
  }
  
  public var body: some View {
    VStack {
      Text("ReportView")
    }
  }
}
