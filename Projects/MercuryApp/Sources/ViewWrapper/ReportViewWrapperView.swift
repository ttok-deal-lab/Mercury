//
//  ReportViewWrapperView.swift
//  MercuryApp
//
//  Created by 최수훈 on 10/8/26.
//

import SwiftUI

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
