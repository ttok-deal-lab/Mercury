//
//  TutorialSelectionViewStep1.swift
//  Tutorial
//
//  Created by 송하민 on 10/5/24.
//

import SwiftUI
import Foundation

import Coordinator

public struct TutorialSelectionCategoryView: View {
  
  @ObservedObject private var coordinator: CoordinatorManager
  
  public init(coordinator: CoordinatorManager) {
    self.coordinator = coordinator
  }
  
  public var body: some View {
    VStack {
       
    }
  }
}
