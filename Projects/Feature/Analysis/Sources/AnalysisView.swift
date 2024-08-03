//
//  AnalysisView.swift
//  Analysis
//
//  Created by 송하민 on 8/3/24.
//

import SwiftUI
import ComposableArchitecture

public struct AnalysisView: View {
  
  public var store: StoreOf<AnalysisReducer>
  
  public var body: some View {
    Text("Analysis")
  }
  
  public init(store: StoreOf<AnalysisReducer>) {
    self.store = store
  }
}
