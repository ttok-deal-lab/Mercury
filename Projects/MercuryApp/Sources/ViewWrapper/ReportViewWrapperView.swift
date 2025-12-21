//
//  ReportViewWrapperView.swift
//  MercuryApp
//
//  Created by 송하민 on 4/13/25.
//

import SwiftUI
import Combine

import Router
import Report

public struct ReportViewWrapperView: View, ReportViewable {
  
  let hostView: ReportView
  
  public init() {
    self.hostView = ReportView()
  }
  
  public var body: some View {
    hostView
  }
}
