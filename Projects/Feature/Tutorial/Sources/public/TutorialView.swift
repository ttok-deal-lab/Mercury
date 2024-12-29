//
//  TutorialView.swift
//  Tutorial
//
//  Created by 송하민 on 12/23/24.
//

import SwiftUI

import Coordinator

public struct TutorialView: View {
  
  let hostView: TutorialIntroView
  
  public init(path: Binding<NavigationPath>) {
    self.hostView = TutorialIntroView(path: path)
  }
  
  public var body: some View {
    hostView
  }
}
