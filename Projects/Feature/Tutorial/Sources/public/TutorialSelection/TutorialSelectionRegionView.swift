//
//  TutorialSelectionViewStep1.swift
//  Tutorial
//
//  Created by 송하민 on 10/5/24.
//

import SwiftUI
import Foundation

import AppFoundation
import UIComponent
import Coordinator

public struct TutorialSelectionRegionView: View {
  
  @ObservedObject private var coordinator: CoordinatorManager
  
  public init(coordinator: CoordinatorManager) {
    self.coordinator = coordinator
  }
  
  public var body: some View {
    VStack {
      Color.red
      Spacer()
      MQButton(title: "준비됐어요!") {
        coordinator.dismissCover()
      }
    }
  }
}
